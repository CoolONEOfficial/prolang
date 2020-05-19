import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/extensions/Color.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/ui/views/home/lang_list/lang_list_model.dart';
import 'package:prolang/ui/views/widgets/PlatformCard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:prolang/ui/views/widgets/ResponsiveSafeArea.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class LangListView extends StatelessWidget {
  const LangListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LangListViewModel>(
      create: (_) => LangListViewModel(context.read),
      builder: (_, child) {
        return const Scaffold(
          body: LangListViewBody._(),
        );
      },
    );
  }
}

class LangListViewBody extends StatelessWidget {
  const LangListViewBody._({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((LangListViewModel viewModel) => viewModel.isLoading);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text("select_lang.title").tr(context: context),
        android: (context) => MaterialAppBarData(centerTitle: true),
      ),
      body: ResponsiveSafeArea(
        child: isLoading ? _loadingIndicator() : _langList(context),
      ),
    );
  }

  Center _loadingIndicator() {
    return Center(
      child: PlatformCircularProgressIndicator(),
    );
  }

  ResponsiveGridList _langList(BuildContext context) {
    final langList =
        context.select((LangListViewModel viewModel) => viewModel.langList);
    final material = isMaterial(context);
    return ResponsiveGridList(
      desiredItemWidth: material ? 170.0 : 150.0,
      minSpacing: material ? 15 : 10,
      children: langList
          .map(
            (lang) => Padding(
              padding:
                  material ? const EdgeInsets.only(top: 15.0) : EdgeInsets.zero,
              child: PlatformCard(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: HexColor.fromHex(lang.color),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black38,
                        ],
                        radius: 0.8
                      ),
                    ),
                    child: PlatformWidget(
                        android: (context) =>
                            _materialCardContent(context, lang),
                        ios: (context) => _cupertinoCardContent(context, lang)),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          )
          .toList(),
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

  Column _cupertinoCardContent(BuildContext context, Lang lang) {
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

  AutoSizeText _cardText(BuildContext context, Lang lang) {
    return AutoSizeText(
      lang.title[context.locale.languageCode],
      style: TextStyle(fontSize: 28, color: Colors.white),
      minFontSize: 18,
      maxLines: 1,
    );
  }
}