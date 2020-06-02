import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:crop/crop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image/image.dart' as I;

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
      title: Text("Обрезка аватара"),
      content: Padding(
        padding: isCupertino(context)
            ? const EdgeInsets.only(top: 16.0)
            : EdgeInsets.zero,
        child: AspectRatio(
          aspectRatio: 1,
          child: LayoutBuilder(builder: (context, constraints) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(constraints.maxWidth / 2),
              child: Crop(
                backgroundColor: Colors.transparent,
                dimColor: Colors.transparent,
                controller: controller,
                child: Image.memory(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        ),
      ),
      actions: kIsWeb
          ? <Widget>[
              PlatformDialogAction(
                child: Icon(Icons.rotate_left),
                onPressed: () async {
                  setState(() {
                    controller.rotation--;
                  });
                },
              ),
              PlatformDialogAction(
                child: Icon(Icons.rotate_right),
                onPressed: () async {
                  setState(() {
                    controller.rotation++;
                  });
                },
              ),
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
          : <Widget>[] +
              <Widget>[
                PlatformDialogAction(
                  child: Text("no_crop".tr()),
                  onPressed: () async {
                    Navigator.pop(context, I.decodeImage(widget.image));
                  },
                ),
                PlatformDialogAction(
                  child: Text("crop".tr()),
                  onPressed: () async {
                    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
                    final cropped =
                        await controller.crop(pixelRatio: pixelRatio);

                    if (cropped == null) {
                      Navigator.pop(context, null);
                      return;
                    }
                    final byteData = await cropped.toByteData();
                    var image = I.Image.fromBytes(
                      cropped.width,
                      cropped.height,
                      byteData.buffer.asUint8List(
                        byteData.offsetInBytes,
                        byteData.lengthInBytes,
                      ),
                    );

                    Navigator.pop(context, image);
                  },
                )
              ],
    );
  }
}
