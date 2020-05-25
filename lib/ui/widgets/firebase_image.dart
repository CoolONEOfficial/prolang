import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prolang/app/services/firebase_storage_service.dart';

import 'loading_indicator.dart';

enum ImageDownloadState { Idle, GettingURL, Downloading, Done, Error }

final _cachedUrls = Map<String, String>();

class FirebaseImage extends StatefulWidget {
  final String path;

  /// The widget that will be displayed if an error occurs.
  final Widget errorWidget;

  final BoxFit fit;

  final double width;

  final double height;

  FirebaseImage(
    this.path, {
    Key key,
    this.errorWidget,
    this.fit,
    this.width,
    this.height,
  });

  @override
  _FirebaseStorageImageState createState() =>
      _FirebaseStorageImageState(path, errorWidget ?? Container());
}

class _FirebaseStorageImageState extends State<FirebaseImage>
    with SingleTickerProviderStateMixin {
  _FirebaseStorageImageState(
    this.path,
    this.errorWidget,
  ) {
    this._imageDownloadState = ImageDownloadState.GettingURL;
    if (!_cachedUrls.containsKey(path)) {
      FirebaseStorageService.loadFromStorage(path)
          .then(this._setImageData)
          .catchError(this._setError);
    }
  }

  @override
  void initState() {
    super.initState();

    if (_cachedUrls.containsKey(path)) {
      _setImageData(_cachedUrls[path]);
    }
  }

  final String path;

  /// The widget that will be displayed if an error occurs.
  final Widget errorWidget;

  /// The image that will be/has been downloaded from the [reference].
  Image _networkImage;

  /// The state of the [_networkImage].
  ImageDownloadState _imageDownloadState = ImageDownloadState.Idle;

  /// Sets the [_networkImage] to the image downloaded from [url].
  void _setImageData(String url) {
    debugPrint("set $url to $path");
    _cachedUrls[path] = url;
    this._networkImage = Image(
      image: CachedNetworkImageProvider(url),
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
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
  void _setError(dynamic err) {
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
