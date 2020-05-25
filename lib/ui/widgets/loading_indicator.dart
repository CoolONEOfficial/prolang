import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/helpers/background_image_path.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            backgroundImagePath(context),
          ),
          repeat: ImageRepeat.repeat,
          alignment: Alignment.center,
        ),
      ),
      child: Center(
        child: PlatformCircularProgressIndicator(
          material: (context, _) => MaterialProgressIndicatorData(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
