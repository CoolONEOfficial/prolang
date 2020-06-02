import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/helpers/app_bar_shape.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/views/form/lang_form_view.dart';
import 'package:prolang/ui/views/home/lang_list/lang_list_view.dart';
import 'package:prolang/ui/widgets/firebase_image.dart';
import 'package:prolang/ui/widgets/platform_progress_dialog.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class LessonAppBar extends StatelessWidget {
  final String basePath;
  final double expandedHeight;

  const LessonAppBar({
    Key key,
    this.basePath,
    this.expandedHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<Lang>();
    final fs = context.watch<FirestoreService>();
    return SliverAppBar(
      leading: ModalRoute.of(context).canPop
          ? null
          : PlatformIconButton(
              icon: Icon(PlatformIcons(context).flag),
              onPressed: () => Navigator.of(context).pushReplacement(
                platformPageRoute(
                  context: context,
                  builder: (context) => LangListView(),
                ),
              ),
            ),
      shape: appBarShape(context),
      expandedHeight: expandedHeight,
      pinned: true,
      actions: lang.teacherId == FirebaseAuthService.cachedCurrentUser.uid ||
              FirebaseAuthService.cachedCurrentUser.isAdmin
          ? <Widget>[
              PlatformIconButton(
                icon: Icon(PlatformIcons(context).delete, color: Colors.white),
                onPressed: () async {
                  showPlatformDialog(
                    context: context,
                    builder: (_) => PlatformAlertDialog(
                      title: Text("lang.delete.confirmation".tr()),
                      actions: <Widget>[
                        PlatformDialogAction(
                          child: PlatformText(
                            "cancel".tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        PlatformDialogAction(
                          cupertino: (_, __) => CupertinoDialogActionData(
                            isDestructiveAction: true,
                          ),
                          child: PlatformText(
                            "delete".tr(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                            showPlatformDialog(
                              context: context,
                              builder: (_) => PlatformProgressDialog(
                                text: "lang.delete.progress".tr(),
                              ),
                            );
                            await fs.deleteLang(lang);
                            Navigator.pop(context);
                            Navigator.pop(context, true);
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
              PlatformIconButton(
                icon: Icon(
                  PlatformIcons(context).create,
                  color: Colors.white,
                ),
                onPressed: () async {
                  if (await Navigator.of(context).push(
                        platformPageRoute(
                          context: context,
                          builder: (context) => LangFormView(
                            lang: lang,
                          ),
                        ),
                      ) ==
                      true) {
                    Navigator.pop(context);
                  }
                },
              )
            ]
          : [],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: isMaterial(context)
                    ? getValueForScreenType(
                        context: context,
                        tablet: 1,
                        mobile: 1,
                      )
                    : 2,
                child: Container(),
              ),
              Flexible(
                flex: 3,
                child: Text(
                  lang.title,
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
        background: Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xCC000000),
                  const Color(0x88000000),
                  Theme.of(context).primaryColor
                ],
                stops: [
                  0.2,
                  0.6,
                  1
                ]),
          ),
          child: FirebaseImage(
            '$basePath/header' +
                getValueForScreenType<String>(
                  context: context,
                  mobile: "_400x400",
                  tablet: "_400x400",
                  desktop: "",
                ) +
                '.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
