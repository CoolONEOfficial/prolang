import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:prolang/app/models/user.dart';
import 'package:prolang/main.dart';
import 'package:prolang/ui/views/home/lang_list/lang_list_view.dart';
import 'package:prolang/ui/views/intro/intro_view.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tuple/tuple.dart';

import 'constants/theme_colors.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initOneSignal();
  }

  initOneSignal() async {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init("714faefa-00c6-4d40-a1b9-9e0ce3017e67", iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    OneSignal.shared
        .setNotificationReceivedHandler(_handleNotificationReceived);
  }

  void _handleNotificationReceived(OSNotification notification) {
    debugPrint("notification received!");
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
        brightness: WidgetsBinding.instance.window.platformBrightness,
        primaryColor: ThemeColors.primaryLight,
        accentColor: ThemeColors.accentLight,
        cardColor: ThemeColors.cardColor(),
        backgroundColor: ThemeColors.backgroundColor(context),
        disabledColor: ThemeColors.disabledColor(context),
        textTheme: TextTheme(
          button: TextStyle(color: ThemeColors.textColor()),
          subtitle1: TextStyle(color: ThemeColors.textColor()),
          headline6: TextStyle(color: ThemeColors.textColor()),
        ),
        secondaryHeaderColor: ThemeColors.secondaryHeaderColor(),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: ThemeColors.textColor()),
          hintStyle: TextStyle(color: ThemeColors.textColor().withOpacity(0.8)),
        ),
        fontFamily: 'TTNorms');
    return Theme(
      data: lightTheme,
      child: PlatformApp(
        title: 'Material App',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalization.of(context).delegate,
        ],
        material: (context, _) {
          return MaterialAppData(
            theme: lightTheme,
            darkTheme: lightTheme.copyWith(
              brightness: Brightness.dark,
              primaryColor: ThemeColors.primaryDark,
              accentColor: ThemeColors.accentDark,
            ),
          );
        },
        cupertino: (context, _) {
          return CupertinoAppData(
            theme: CupertinoThemeData(
              primaryColor: ThemeColors.primaryLight,
              primaryContrastingColor: ThemeColors.accentLight,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                  fontFamily: 'TTNorms',
                  color: ThemeColors.textColor(),
                ),
                primaryColor: ThemeColors.primaryLight,
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
