import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/ui/views/home/lang/lang_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:prolang/ui/widgets/platform_card.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:provider/provider.dart';

import '../lang_list_view_model.dart';

class LangEntry extends StatelessWidget {
  final Lang lang;

  const LangEntry(
    this.lang, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PlatformCard(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: TinyColor.fromString(lang.color).color,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  Colors.black38,
                ],
                radius: 0.8,
              ),
            ),
            child: PlatformWidget(
              material: (context, _) => _materialCardContent(context, lang),
              cupertino: (context, _) => _cupertinoCardContent(context, lang),
            ),
          ),
        ),
        onPressed: () async {
          if (await Navigator.push(
            context,
            platformPageRoute(
              context: context,
              builder: (_) => LangView(
                lang,
                iosTitle: "lang_list.title".tr(),
              ),
            ),
          ) == true) {
            context.read<LangListViewModel>().loadLangList();
          }
        },
      ),
    );
  }

  Column _materialCardContent(BuildContext context, Lang lang) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          lang.flag,
          style: TextStyle(fontSize: 60),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _cardText(context, lang),
        ),
        Spacer(),
      ],
    );
  }

  Widget _cupertinoCardContent(BuildContext context, Lang lang) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          lang.flag,
          style: TextStyle(fontSize: 80),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -15.0, 0.0),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _cardText(context, lang),
        ),
        Spacer(),
      ],
    );
  }

  Widget _cardText(BuildContext context, Lang lang) {
    return AutoSizeText(
      lang.title,
      style: TextStyle(fontSize: 28, color: Colors.white),
      maxLines: 1,
    );
  }
}
