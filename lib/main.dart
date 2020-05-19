import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/services/firebase_auth_service.dart';

void main() => runApp(
  EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      /// Inject the [FirebaseAuthService]
      /// and provide a stream of [User]
      ///
      /// This needs to be above [MaterialApp]
      /// At the top of the widget tree, to
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
            create: (context) =>
                context.read<FirebaseAuthService>().onAuthStateChanged,
          ),
        ],
        child: MyApp(),
      )
    )
    );
