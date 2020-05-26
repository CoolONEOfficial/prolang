import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:prolang/app/helpers/app_bar_shape.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/ui/views/home/lang_list/widgets/lang_entry.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'lang_list_view_model.dart';

class LangListView extends StatelessWidget {
  const LangListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LangListViewModel>(
      create: (_) => LangListViewModel(context.read),
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
    final isLoading =
        context.select((LangListViewModel viewModel) => viewModel.isLoading);
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
          trailingActions: <Widget>[
            PlatformButton(
              child: Text("Signout"),
              color: Colors.transparent,
              onPressed: () {
                context.read<FirebaseAuthService>().signOut();
              },
            )
          ],
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
      children: langList.map((lang) => LangEntry(lang)).toList(),
    );
  }
}
