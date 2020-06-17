import 'package:card_settings/card_settings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:prolang/app/app.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/ui/widgets/platform_progress_dialog.dart';
import 'package:prolang/ui/widgets/responsive_content.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';

class EmailSignInStart extends StatefulWidget {
  @override
  _EmailSignInStartState createState() => _EmailSignInStartState();
}

class _EmailSignInStartState extends State<EmailSignInStart> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String passwordConfirm = "";

  bool passwordVisible = false;
  bool newPasswordVisible = false;

  onDonePressed() async {
    if (_formKey.currentState.validate() &&
        (newPasswordVisible || passwordVisible)) {
      showPlatformDialog(
        context: context,
        builder: (_) => PlatformProgressDialog(
          text: "intro.auth.progress".tr(),
        ),
      );

      final auth = context.read<FirebaseAuthService>();
      try {
        final res = await (newPasswordVisible
            ? auth.registerEmailAndPassword(email, password)
            : auth.loginEmailAndPassword(email, password));

        if (res.user == null) {
          Navigator.of(context).pop(false);
        } else {
          await Future.delayed(Duration(seconds: 3));
          MyApp.restartApp(context);
        }
      } finally {
        Navigator.of(context).pop();
      }
    }
  }

  didEmailApplied(FirebaseAuthService auth) async {
    if (EmailValidator.validate(email)) {
      final registered = await auth.isMailRegistered(email);
      setState(() {
        passwordVisible = registered;
        newPasswordVisible = !registered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<FirebaseAuthService>();
    return Container(
      color: Theme.of(context).primaryColor,
      child: ResponsiveContent(
        child: PlatformScaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          appBar: PlatformAppBar(
            material: (_, __) => MaterialAppBarData(elevation: 0),
            title: Text("intro.auth.email.title").tr(),
            trailingActions: <Widget>[
              PlatformIconButton(
                icon: Icon(PlatformIcons(context).done),
                onPressed: onDonePressed,
              )
            ],
          ),
          body: Form(
            autovalidate: true,
            key: _formKey,
            child: CardSettings(
              labelWidth: 140,
              children: [
                CardSettingsSection(children: [
                  CardSettingsText(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autofocus: true,
                    contentOnNewLine: false,
                    maxLength: 30,
                    maxLengthEnforced: true,
                    hintText: 'intro.auth.email.email.hint'.tr(),
                    label: 'intro.auth.email.email.label'.tr(),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'required_field'.tr();
                      if (!EmailValidator.validate(value))
                        return "intro.auth.email.email.error.incorrect".tr();
                    },
                    onFieldSubmitted: (value) {
                      email = value;
                      didEmailApplied(auth);
                    },
                    onChanged: (_) {
                      setState(() {
                        passwordVisible = false;
                        newPasswordVisible = false;
                      });
                    },
                  ),
                  CardSettingsPassword(
                    visible: passwordVisible || newPasswordVisible,
                    label: 'intro.auth.email.password.label'.tr(),
                    hintText: 'intro.auth.email.password.hint'.tr(),
                    validator: (value) {
                      if (!passwordVisible) return null;
                      if (value == null || value.isEmpty)
                        return 'required_field'.tr();
                      if (value.length < 6)
                        return "intro.auth.email.password.error.small".tr();
                    },
                    onChanged: (value) => password = value,
                  ),
                  CardSettingsPassword(
                    visible: newPasswordVisible,
                    label: 'intro.auth.email.password_confirm.label'.tr(),
                    hintText: 'intro.auth.email.password_confirm.hint'.tr(),
                    validator: (value) {
                      if (!newPasswordVisible) return null;
                      if (value != password)
                        return 'intro.auth.email.password_confirm.error.same'
                            .tr();
                    },
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
