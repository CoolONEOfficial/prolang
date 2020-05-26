import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveContent extends StatelessWidget {
  final Widget child;

  const ResponsiveContent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: child,
      tablet: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 5,
        ),
        child: child,
      ),
    );
  }
}
