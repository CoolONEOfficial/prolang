import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EmailSignInConfirmation extends StatelessWidget {
  const EmailSignInConfirmation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final auth = context.watch<FirebaseAuthService>();
    return Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(
            "Confirm your mail and reopen app",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ));
  }
}
