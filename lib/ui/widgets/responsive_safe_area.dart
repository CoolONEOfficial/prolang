import 'package:flutter/widgets.dart';
import 'package:prolang/app/helpers/background_image_path.dart';
import 'package:prolang/ui/widgets/responsive_content.dart';
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
        ResponsiveContent(child: super.build(context)),
      ],
    );
  }
}
