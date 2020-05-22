
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tuple/tuple.dart';

import 'intro_view_model.dart';
import 'widgets/anonymous_sign_in_button.dart';
import 'widgets/google_sign_in_button.dart';

class IntroView extends StatelessWidget {
  const IntroView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IntroViewModel>(
      create: (_) => IntroViewModel(context.read),
      builder: (_, child) {
        return const Scaffold(
          body: _IntroViewBody._(),
        );
      },
    );
  }
}

class _IntroViewBody extends StatefulWidget {
  const _IntroViewBody._({Key key}) : super(key: key);

  @override
  _SignInViewBodyState createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<_IntroViewBody> {
  static const List<Tuple3<String, IconData, Color>> slidesMap = [
    Tuple3("baloon", MaterialCommunityIcons.balloon, Color(0xff03a9f4)),
    Tuple3("water", MaterialCommunityIcons.water_off, Color(0xff4caf50)),
    Tuple3("world", MaterialCommunityIcons.web, Color(0xffff9800)),
    Tuple3("feedback", MaterialCommunityIcons.chat, Color(0xff795548)),
    Tuple3("rumour", MaterialCommunityIcons.volume_high, Color(0xff9e9e9e)),
    Tuple3("groups", MaterialCommunityIcons.account_group, Color(0xff607d8b)),
  ];

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width / 10 * 3;
    return IntroSlider(
      slides: _slides(context),
      isShowDoneBtn: false,
      colorDot: Colors.white38,
      colorActiveDot: Colors.white,
      nameNextBtn: "next".tr(),
      nameSkipBtn: "skip".tr(),
      widthSkipBtn: buttonWidth,
      widthDoneBtn: buttonWidth,
    );
  }

  List<Slide> _slides(BuildContext context) {
    return [
          Slide(
            title: "title".tr(),
            maxLineTitle: 2,
            description: "subtitle".tr(),
            pathImage: "assets/images/logo.png",
            backgroundColor: Theme.of(context).primaryColor,
            styleTitle: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            marginTitle: _marginTitle(context),
            styleDescription: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          )
        ] +
        slidesMap
            .map(
              (slide) => Slide(
                widgetTitle: AutoSizeText(
                  "intro.${slide.item1}.title".tr(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TTNorms',
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                maxLineTitle: 2,
                widgetDescription: _description(
                  context,
                  "intro.${slide.item1}.description".tr(),
                ),
                marginTitle: _marginTitle(context),
                centerWidget: Icon(
                  slide.item2,
                  color: Colors.white,
                  size: 200,
                ),
                backgroundColor: slide.item3,
              ),
            )
            .toList() +
        [
          Slide(
            title: "intro.auth.title".tr(),
            centerWidget: Column(
              children: <Widget>[
                Icon(
                  MaterialCommunityIcons.teach,
                  color: Colors.white,
                  size: 200,
                ),
                SizedBox(height: 30),
                _description(context, "intro.auth.description".tr()),
              ],
            ),
            marginTitle: _marginTitle(context),
            backgroundColor: Theme.of(context).primaryColor,
            widgetDescription: _signInButtons(),
          )
        ];
  }

  static Widget _description(BuildContext context, String text) {
    return Row(
      children: <Widget>[
        Spacer(),
        Container(
          width: getValueForScreenType<double>(
            context: context,
            mobile: MediaQuery.of(context).size.width - 60,
            desktop: MediaQuery.of(context).size.width / 3,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ).tr(),
        ),
        Spacer(),
      ],
    );
  }

  static EdgeInsets _marginTitle(BuildContext context) {
    return EdgeInsets.only(
      top: getValueForScreenType<double>(
        context: context,
        mobile: 60,
        tablet: MediaQuery.of(context).size.height / 4,
      ),
      bottom: 60,
    );
  }

  static Row _signInButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const AnonymousSignInButton(),
        const GoogleSignInButton(),
      ],
    );
  }
}
