import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/models/user.dart';
import 'package:prolang/main.dart';
import 'package:prolang/ui/views/home/lang_list/lang_list_view.dart';
import 'package:prolang/ui/views/intro/intro_view.dart';
import 'package:prolang/ui/views/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tuple/tuple.dart';

import 'constants/ThemeColors.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      primaryColor: ThemeColors.primaryLight,
      accentColor: ThemeColors.accentLight,
      cardColor: ThemeColors.cardColor(context),
      fontFamily: 'TTNorms'
    );
    return Theme(
      data: lightTheme,
      child: PlatformApp(
        title: 'Material App',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalization.of(context).delegate,
        ],
        android: (context) {
          return MaterialAppData(
            theme: lightTheme,
            darkTheme: lightTheme.copyWith(
              brightness: Brightness.dark,
              primaryColor: ThemeColors.primaryDark,
              accentColor: ThemeColors.accentDark,
            ),
          );
        },
        ios: (context) {
          return CupertinoAppData(
            theme: CupertinoThemeData(
              primaryColor: ThemeColors.primaryLight,
              primaryContrastingColor: ThemeColors.accentLight,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                  fontFamily: 'TTNorms',
                  color: ThemeColors.textColor(context),
                ),
              ),
            ),
          );
        },
        home: Consumer<Tuple2<UserState, User>>(
          builder: (_, user, __) {
            switch (user.item1) {
              case UserState.Loading:
                return LoadingIndicator();
              case UserState.Done:
                return user.item2 == null
                    ? const IntroView()
                    : const LangListView();
            }
          },
        ),
      ),
    );
  }
}
