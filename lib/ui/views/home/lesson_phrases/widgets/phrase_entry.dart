import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/constants/firebase_paths.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/models/phrase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:prolang/app/services/firebase_auth_service.dart';
import 'package:prolang/app/services/firebase_storage_service.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/views/form/lesson_phrase_form_view.dart';
import 'package:prolang/ui/views/home/lesson_phrases/lesson_phrases_view_model.dart';
import 'package:provider/provider.dart';

class PhraseEntry extends StatefulWidget {
  final Phrase phrase;

  const PhraseEntry(
    this.phrase, {
    Key key,
  }) : super(key: key);

  @override
  _PhraseEntryState createState() => _PhraseEntryState();
}

class _PhraseEntryState extends State<PhraseEntry>
    with SingleTickerProviderStateMixin {
  bool _hidden = true;

  Animation<double> _animation;
  AnimationController _controller;

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300));
    Tween tween = Tween<double>(begin: 10.0, end: 0.0);
    _animation = tween.animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _playAudio(
    Lang lang,
    LessonSection section,
    Lesson lesson,
  ) async {
    AudioPlayer.logEnabled = true;
    final path =
        FirebasePaths.phrasePath(lang, section, lesson, widget.phrase) +
            '/audio.mp3';
    final url = await FirebaseStorageService.loadFromStorage(path);
    audioPlayer.play(url);
  }

  @override
  Widget build(BuildContext context) {
    final fs = context.watch<FirestoreService>();
    final vm = context.watch<LessonPhrasesViewModel>();
    final lang = context.watch<Lang>();
    final section = context.watch<LessonSection>();
    final lesson = context.watch<Lesson>();

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: AutoSizeText(
                widget.phrase.original,
                minFontSize: 18,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            PlatformIconButton(
              icon: Icon(
                isMaterial(context)
                    ? _hidden
                        ? MaterialCommunityIcons.eye
                        : MaterialCommunityIcons.eye_off
                    : _hidden ? Ionicons.ios_eye : Ionicons.ios_eye_off,
              ),
              onPressed: () {
                setState(() {
                  if (_hidden == false &&
                      _animation.status == AnimationStatus.completed) {
                    _controller.reverse();
                    _hidden = true;
                    audioPlayer.stop();
                  } else if (_hidden == true &&
                      _animation.status == AnimationStatus.dismissed) {
                    _controller.forward();
                    _hidden = false;
                    if (vm.isAudioEnabled) {
                      _playAudio(lang, section, lesson);
                    }
                  }
                });
              },
            ),
          ]..insertAll(
              1,
              FirebaseAuthService.cachedCurrentUser.uid == lang.teacherId
                  ? [
                      PlatformIconButton(
                        icon: Icon(PlatformIcons(context).create),
                        onPressed: () => Navigator.of(context).push(
                          platformPageRoute(
                            context: context,
                            builder: (context) => LessonPhraseFormView(
                              lang: lang,
                              section: section,
                              lesson: lesson,
                              phrase: widget.phrase,
                            ),
                          ),
                        ),
                      ),
                      PlatformIconButton(
                        icon: Icon(PlatformIcons(context).delete),
                        onPressed: () => showPlatformDialog(
                          context: context,
                          builder: (_) => PlatformAlertDialog(
                            title:
                                Text("lesson_phrase.delete.confirmation".tr()),
                            actions: <Widget>[
                              PlatformDialogAction(
                                child: PlatformText(
                                  "cancel".tr(),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              PlatformDialogAction(
                                cupertino: (c, _) => CupertinoDialogActionData(
                                  isDestructiveAction: true,
                                ),
                                child: PlatformText(
                                  "delete".tr(),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context, true);
                                  await fs.deleteLessonPhrase(
                                    lang,
                                    section,
                                    lesson,
                                    widget.phrase,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ]
                  : []),
        ),
        SizedBox(height: 5),
        _translatedText(context),
      ],
    );
  }

  Widget _translatedText(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32;
    return Container(
      height: 55.0,
      width: width,
      child: Stack(
        children: <Widget>[
          Container(
            height: 55.0,
            width: width,
            child: AutoSizeText(
              widget.phrase.translated,
              minFontSize: 18,
              maxLines: 2,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (_, __) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: _animation.value, sigmaY: _animation.value),
                child: Container(
                    width: width,
                    height: 200.0,
                    decoration: BoxDecoration(color: Colors.transparent)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
