import 'package:flutter/material.dart';
import 'package:prolang/app/plugins/storage/fire_storage_service.dart';

import 'loading_indicator.dart';

enum ImageDownloadState { Idle, GettingURL, Downloading, Done, Error }

class FirebaseImage extends StatefulWidget {
  final String path;

  /// The widget that will be displayed if an error occurs.
  final Widget errorWidget;

  final BoxFit fit;

  FirebaseImage(
    this.path, {
    Key key,
    this.errorWidget,
    this.fit,
  });

  @override
  _FirebaseStorageImageState createState() => _FirebaseStorageImageState(
      path, errorWidget ?? Container());
}

class _FirebaseStorageImageState extends State<FirebaseImage>
    with SingleTickerProviderStateMixin {
  _FirebaseStorageImageState(
    this.path,
    this.errorWidget,
  ) {
    debugPrint("pathhg: $path");
    var url = FireStorageService.loadFromStorage(context, path);
    this._imageDownloadState = ImageDownloadState.GettingURL;
    url.then(this._setImageData).catchError((err) {
      debugPrint("ERROR: $err");
      this._setError();
    });
  }

  final String path;

  /// The widget that will be displayed if an error occurs.
  final Widget errorWidget;

  /// The image that will be/has been downloaded from the [reference].
  Image _networkImage;

  /// The state of the [_networkImage].
  ImageDownloadState _imageDownloadState = ImageDownloadState.Idle;

  /// Sets the [_networkImage] to the image downloaded from [url].
  void _setImageData(dynamic url) {
    this._networkImage = Image.network(
      url.toString(),
      fit: widget.fit,
    );
    this
        ._networkImage
        .image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((_, __) {
      if (mounted)
        setState(() => this._imageDownloadState = ImageDownloadState.Done);
    }));
    if (this._imageDownloadState != ImageDownloadState.Done)
      this._imageDownloadState = ImageDownloadState.Downloading;
  }

  /// Sets the [_imageDownloadState] to [ImageDownloadState.Error] and redraws the UI.
  void _setError() {
    if (mounted)
      setState(() => this._imageDownloadState = ImageDownloadState.Error);
  }

  @override
  Widget build(BuildContext context) {
    switch (this._imageDownloadState) {
      case ImageDownloadState.Idle:
      case ImageDownloadState.GettingURL:
      case ImageDownloadState.Downloading:
        return LoadingIndicator();
      case ImageDownloadState.Error:
        return this.errorWidget;
      case ImageDownloadState.Done:
        return this._networkImage;
        break;
      default:
        return this.errorWidget;
    }
  }
}
