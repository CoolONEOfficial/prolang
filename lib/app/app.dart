import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../ui/views/authentication/sign_in/sign_in_view.dart';
import '../ui/views/home/home_view.dart';
import 'models/user.dart';

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
      home: Consumer<User>(
        builder: (_, user, __) {
          if (user == null) {
            return const SignInView();
          } else {
            return const HomeView();
          }
        },
      ),
    );
  }
}
