import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveSafeArea extends StatelessWidget {
  const ResponsiveSafeArea({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: isMaterial(context),
      child: ScreenTypeLayout(
        mobile: child,
        tablet: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 5,
          ),
          child: child,
        ),
        desktop: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 5,
          ),
          child: child,
        ),
        watch: child,
      ),
    );
  }
}
