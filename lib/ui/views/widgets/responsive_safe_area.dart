import 'package:flutter/widgets.dart';
import 'package:prolang/app/helpers/background_image_path.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveSafeArea extends SafeArea {
  const ResponsiveSafeArea({
    Key key,
    Widget child,
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
    bool maintainBottomViewPadding = false,
  }) : super(
          key: key,
          child: child,
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          minimum: minimum,
          maintainBottomViewPadding: maintainBottomViewPadding,
        );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          backgroundImagePath(context),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          repeat: ImageRepeat.repeat,
          alignment: Alignment.center,
        ),
        ScreenTypeLayout(
          mobile: super.build(context),
          tablet: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 5,
            ),
            child: super.build(context),
          ),
        ),
      ],
    );
  }
}
