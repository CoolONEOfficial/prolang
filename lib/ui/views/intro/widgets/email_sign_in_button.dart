import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:prolang/ui/views/intro/email/email_sign_in_start.dart';

class EmailSignInButton extends StatelessWidget {
  const EmailSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        color: ThemeColors.primaryDarken(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        onPressed: () {
          Navigator.of(context).push(
            platformPageRoute(
              context: context,
              builder: (context) => EmailSignInStart(),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Icon(
              PlatformIcons(context).mail,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "intro.auth.button.email".tr(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
