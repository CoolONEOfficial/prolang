import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadButton extends StatefulWidget {
  final Future<String> url;
  final String fileName;

  const DownloadButton({
    Key key,
    this.url,
    this.fileName,
  }) : super(key: key);

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  String _localPath;
  bool isLoading = false;
  String taskId;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    if (!kIsWeb) {
      _bindBackgroundIsolate();
      FlutterDownloader.registerCallback(downloadCallback);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      _unbindBackgroundIsolate();
    }
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      // if (debug) {
      print('UI Isolate Callback: $data');
      // }
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      // final task = _tasks?.firstWhere((task) => task.taskId == id);
      // if (task != null) {
      if (status == DownloadTaskStatus.complete) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  Future<Null> _prepare() async {
    await _checkPermission();

    final savedDir = Directory(await _getLocalPath());
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String> _getLocalPath() async {
    if (_localPath == null) {
      final directory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      _localPath = directory.path;
    }

    return _localPath;
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      PermissionStatus permission = await Permission.storage.status;
      if (permission != PermissionStatus.granted) {
        PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? PlatformIconButton(
            icon: Icon(PlatformIcons(context).downArrow),
            onPressed: () async => launch(await widget.url),
          )
        : isLoading == true
            ? LoadingIndicator()
            : FutureBuilder<bool>(
                future: _getLocalPath().then(
                  (localPath) =>
                      File(localPath + Platform.pathSeparator + widget.fileName)
                          .exists(),
                ),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.done &&
                          !snapshot.hasError
                      ? snapshot.data
                          ? PlatformIconButton(
                              icon: Icon(PlatformIcons(context).folderOpen),
                              onPressed: () async => OpenFile.open(
                                await _getLocalPath() +
                                    Platform.pathSeparator +
                                    widget.fileName,
                              ),
                            )
                          : PlatformIconButton(
                              icon: Icon(PlatformIcons(context).downArrow),
                              onPressed: () async {
                                await _prepare();
                                FlutterDownloader.enqueue(
                                  url: await widget.url,
                                  savedDir: await _getLocalPath(),
                                  fileName: widget.fileName,
                                  showNotification: true,
                                  openFileFromNotification: true,
                                );
                                setState(() {
                                  isLoading = true;
                                });
                              },
                            )
                      : LoadingIndicator();
                },
              );
  }
}
