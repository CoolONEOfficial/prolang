import 'dart:typed_data';

import 'package:crop/crop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:easy_localization/easy_localization.dart';

class ImageCropDialog extends StatefulWidget {
  final Uint8List image;

  const ImageCropDialog(
    this.image, {
    Key key,
  }) : super(key: key);

  @override
  _ImageCropDialogState createState() => _ImageCropDialogState();
}

class _ImageCropDialogState extends State<ImageCropDialog> {
  final controller = CropController(aspectRatio: 1);

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: Text("Crop image"),
      content: AspectRatio(
        aspectRatio: 1,
        child: Crop(
          backgroundColor: Colors.transparent,
          dimColor: Colors.transparent,
          controller: controller,
          child: Image.memory(
            widget.image,
            fit: BoxFit.cover,
          ),
          helper: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).textTheme.bodyText1.color, width: 2),
            ),
          ),
        ),
      ),
      actions: kIsWeb
          ? [
              PlatformDialogAction(
                child: Icon(Icons.zoom_in),
                onPressed: () async {
                  setState(() {
                    controller.scale += 0.5;
                  });
                },
              ),
              PlatformDialogAction(
                child: Icon(Icons.zoom_out),
                onPressed: () async {
                  setState(() {
                    controller.scale -= 0.5;
                  });
                },
              ),
            ]
          : [] +
              [
                PlatformDialogAction(
                  child: Text("attach".tr()),
                  onPressed: () async {
                    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
                    final cropped =
                        await controller.crop(pixelRatio: pixelRatio);

                    Navigator.pop(context, cropped);
                  },
                )
              ],
    );
  }
}
