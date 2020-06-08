import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:prolang/app/helpers/app_bar_shape.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/views/form/lang_form_view.dart';
import 'package:prolang/ui/views/home/lang_list/widgets/lang_entry.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';
import 'package:prolang/ui/widgets/platform_card.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'lang_list_view_model.dart';

class LangListView extends StatelessWidget {
  const LangListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LangListViewModel>(
      create: (_) => LangListViewModel(
        context.read,
        context.watch<FirestoreService>(),
        context.watch<FirebaseAuthService>(),
      ),
      builder: (_, child) => const Scaffold(
        body: _LangListViewBody._(),
      ),
    );
  }
}

class _LangListViewBody extends StatelessWidget {
  const _LangListViewBody._({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<LangListViewModel>().isLoading;
    return ResponsiveSafeArea(
      bottom: false,
      child: PlatformScaffold(
        backgroundColor: Colors.transparent,
        appBar: PlatformAppBar(
          title: Text("lang_list.title").tr(context: context),
          material: (context, _) => MaterialAppBarData(
            centerTitle: true,
            shape: appBarShape(context),
          ),
          leading: PlatformIconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              isMaterial(context) ? Ionicons.md_exit : Ionicons.ios_exit,
              color: Colors.white,
            ),
            color: Colors.transparent,
            onPressed: () async {
              await context.read<FirebaseAuthService>().signOut();
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: isLoading ? LoadingIndicator() : _langList(context),
      ),
    );
  }

  Widget _langList(BuildContext context) {
    final langList =
        context.select((LangListViewModel viewModel) => viewModel.langList);
    final material = isMaterial(context);
    return ResponsiveGridList(
      desiredItemWidth: material ? 170.0 : 150.0,
      minSpacing: 0,
      children: langList.map<Widget>((lang) => LangEntry(lang)).toList()
        ..addAll(
          FirebaseAuthService.cachedCurrentUser.isAdmin
              ? <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PlatformCard(
                      color: Theme.of(context).primaryColor,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Center(
                          child: Icon(
                            PlatformIcons(context).add,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (await Navigator.of(context).push(
                              platformPageRoute(
                                context: context,
                                builder: (context) => LangFormView(
                                  insertPosition: langList.length,
                                ),
                              ),
                            ) ==
                            true) {
                          context.read<LangListViewModel>().loadLangList();
                        }
                      },
                    ),
                  ),
                ]
              : [],
        ),
    );
  }
}
