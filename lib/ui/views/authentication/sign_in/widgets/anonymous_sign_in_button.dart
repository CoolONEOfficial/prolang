import 'package:flutter/material.dart';
import 'package:prolang/ui/views/authentication/sign_in/sign_in_view_model.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AnonymousSignInButton extends StatelessWidget {
  const AnonymousSignInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        context.read<SignInViewModel>().signInAnonymously();
      },
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.red[900],
      child: Text(
        "auth.anonymous".tr(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
