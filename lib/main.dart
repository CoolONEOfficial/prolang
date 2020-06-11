import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'app/app.dart';
import 'app/models/user.dart';
import 'app/services/firebase_auth_service.dart';

void main() => runApp(
      EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
        path: 'assets/translations',
        fallbackLocale: Locale('ru', 'RU'),

        /// Inject the [FirebaseAuthService]
        /// and provide a stream of [User]
        ///
        /// This needs to be above [MaterialApp]
        /// At the top of the widget tree, toc
        /// accomodate for navigations in the app
        child: MultiProvider(
          providers: [
            Provider(
              create: (_) => FirebaseAuthService(),
            ),
            Provider(
              create: (_) => FirestoreService(),
            ),
            StreamProvider(
              initialData: Tuple2<UserState, User>(UserState.Loading, null),
              create: (context) =>
                  context.read<FirebaseAuthService>().onAuthStateChanged,
            ),
          ],
          child: MyApp(),
        ),
      ),
    );
