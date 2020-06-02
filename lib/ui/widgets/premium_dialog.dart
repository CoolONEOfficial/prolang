import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/ui/views/intro/widgets/google_sign_in_button.dart';
import 'package:prolang/ui/widgets/platform_card.dart';
import 'package:prolang/ui/widgets/platform_card_button.dart';
import 'package:prolang/ui/widgets/platform_progress_dialog.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

final flutterWebviewPlugin = FlutterWebviewPlugin();

class PremiumDialog extends StatelessWidget {
  final Lang lang;
  final LessonSection section;

  const PremiumDialog(
    this.lang,
    this.section, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformCard(
        child: Container(
          width: getValueForScreenType(
            context: context,
            mobile: MediaQuery.of(context).size.width / 5 * 4,
            tablet: 300,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    "Благодарим за прохождение бесплатного курса",
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: "Стоимость полного курса:\n",
                      style: Theme.of(context).textTheme.headline5,
                      children: [
                        TextSpan(
                          text: section.price.toString(),
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        TextSpan(
                          text: '\nрублей',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                  child: StreamBuilder(
                    stream:
                        context.watch<FirebaseAuthService>().onAuthStateChanged,
                    builder: (context, _) => FirebaseAuthService
                                .cachedCurrentUser.email?.isEmpty ??
                            true
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Для приобретения необходимо авторизироваться",
                                style: Theme.of(context).textTheme.headline5,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[GoogleSignInButton()],
                              ),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              PlatformCardButton(
                                color: Theme.of(context).primaryColor,
                                child: Text("Оплатить",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                onPressed: () => _payPressed(context),
                              )
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Map> _callPay() async => (await CloudFunctions.instance
              .getHttpsCallable(
        functionName: 'buySection',
      )
              .call(<String, dynamic>{
        'langId': lang.documentId,
        'sectionId': section.documentId
      }))
          .data as Map;

  _payPressed(BuildContext context) async {
    showPlatformDialog(
      context: context,
      builder: (context) =>
          PlatformProgressDialog(text: "Инициализирую платеж..."),
    );

    final callResult = await _callPay();

    if (callResult.containsKey("err")) {
      Navigator.pop(context);
      return;
    } else {
      final url = callResult["payment"]["confirmation"]["confirmation_url"];

      if (kIsWeb) {
        launch(url);
        Navigator.pop(context);
        showPlatformDialog(
          context: context,
          builder: (context) => PlatformAlertDialog(
              title: Text("Подтверждение покупки"),
              content: Text(
                  "После подтверждения оплаты доступ к курсу будет предоставлен."),
              actions: <Widget>[
                PlatformDialogAction(
                  child: Text("dismiss".tr()),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ]),
        );
      } else {
        final listenSubscription = flutterWebviewPlugin.onUrlChanged.listen(
          (String url) async {
            if (url.contains("://proyaziki.ru")) {
              await flutterWebviewPlugin.close();
              int count = 0;
              Navigator.popUntil(context, (route) {
                return count++ == 2;
              });
              _payEnded(context);
            }
          },
        );

        await Navigator.push(
          context,
          platformPageRoute(
            context: context,
            builder: (context) => WebviewScaffold(
              url: url,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: PlatformAppBar(
                  title: Text("Оплата"),
                ),
              ),
            ),
          ),
        );

        listenSubscription.cancel();

        Navigator.pop(context);
      }
    }
  }

  _payEnded(BuildContext context) async {
    showPlatformDialog(
      context: context,
      builder: (context) => PlatformProgressDialog(
        text: "Проверяю платеж...",
      ),
    );

    final callResult = await _callPay();

    if (callResult.containsKey("err")) {
      Navigator.pop(context);
      return;
    } else {
      final paymentStatus = callResult["payment"]["status"];

      Navigator.pop(context);

      showPlatformDialog(
        context: context,
        builder: (context) => PlatformAlertDialog(
          title: Text("Статус платежа"),
          content: Text(
            paymentStatus == "succeeded"
                ? "Спасибо за покупку!"
                : "Чтото пошло не так,\nпопробуйте еще раз.",
          ),
          actions: <Widget>[
            PlatformDialogAction(
              child: Text("dismiss".tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
