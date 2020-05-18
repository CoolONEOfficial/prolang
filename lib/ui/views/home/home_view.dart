import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../app/constants/strings.dart';
import '../../../app/services/firebase_auth_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("title").tr(context: context),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Home Page',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const Spacer(),
            RaisedButton(
              onPressed: () {
                context.read<FirebaseAuthService>().signOut();
              },
              child: Text(Strings.signOut),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
