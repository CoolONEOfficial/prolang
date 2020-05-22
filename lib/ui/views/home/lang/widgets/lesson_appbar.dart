import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/ui/widgets/firebase_image.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../lang_view.dart';

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
    return SliverAppBar(
      actions: <Widget>[
        PlatformIconButton(
          icon: Icon(
            PlatformIcons(context).create,
            color: Colors.white,
          ),
          onPressed: () => LangView.createSection(
            context,
            lang: lang,
          ),
        ),
      ],
      shape: getValueForScreenType(
        context: context,
        mobile: null,
        tablet: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
      ),
      expandedHeight: expandedHeight,
      pinned: true,
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
                  lang.title[context.locale.languageCode],
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
