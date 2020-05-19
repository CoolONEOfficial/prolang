import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/models/user.dart';
import 'package:prolang/ui/views/authentication/sign_in/sign_in_view.dart';
import 'package:prolang/ui/views/home/lang_list/lang_list_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'Material App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      android: (context) => MaterialAppData(
        theme: ThemeData(
          primaryColor: Colors.deepPurple[400],
          accentColor: Colors.orangeAccent[300]
        )
      ),
      ios: (context) => CupertinoAppData(
        theme: CupertinoThemeData(
          primaryColor: Colors.deepPurple[400],
          primaryContrastingColor: Colors.orangeAccent[300]
        )
      ),
      home: Consumer<User>(
        builder: (_, user, __) {
          if (user == null) {
            return const SignInView();
          } else {
            return const LangListView();
          }
        },
      ),
    );
  }
}
