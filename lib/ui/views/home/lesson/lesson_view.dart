import 'package:chewie/chewie.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:prolang/app/helpers/app_bar_shape.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/app/services/firestore_service.dart';
import 'package:prolang/ui/views/home/lesson/lesson_view_model.dart';
import 'package:prolang/ui/views/home/lesson/widgets/pdf_dialog.dart';
import 'package:prolang/ui/views/home/lesson_phrases/lesson_phrases_view.dart';
import 'package:prolang/ui/views/home/lesson_test/lesson_test_view.dart';
import 'package:prolang/ui/widgets/loading_indicator.dart';
import 'package:prolang/ui/widgets/platform_card_button.dart';
import 'package:prolang/ui/widgets/responsive_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'widgets/video_scaffold.dart';

class LessonView extends StatelessWidget {
  final Lesson lesson;
  final LessonSection section;
  final Lang lang;

  const LessonView({
    Key key,
    this.lesson,
    this.section,
    this.lang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Lesson>(
          create: (_) => lesson,
        ),
        Provider<LessonSection>(
          create: (_) => section,
        ),
        Provider<Lang>(
          create: (_) => lang,
        ),
      ],
      child: ChangeNotifierProvider<LessonViewModel>(
        create: (_) => LessonViewModel(context.read, lesson, section, lang),
        builder: (_, child) => ResponsiveSafeArea(
          child: PlatformScaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(child: _LessonViewBody._()),
            appBar: PlatformAppBar(
              title: Text(lesson.title),
              material: (context, _) => MaterialAppBarData(
                shape: appBarShape(context),
              ),
              cupertino: (context, _) => CupertinoNavigationBarData(
                previousPageTitle: section.title,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LessonViewBody extends StatefulWidget {
  const _LessonViewBody._({
    Key key,
  }) : super(key: key);

  @override
  _LessonViewBodyState createState() => _LessonViewBodyState();
}

class _LessonViewBodyState extends State<_LessonViewBody> {
  VideoPlayerController _videoPlayerController;
  VideoPlayerController _audioPlayerController;
  ChewieController _chewieVideoController;
  ChewieAudioController _chewieAudioController;

  @override
  void initState() {
    final fs = context.read<FirestoreService>();
    final lang = context.read<Lang>();
    fs.updateUserCurrentLang(lang);
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _audioPlayerController?.dispose();
    _chewieVideoController?.dispose();
    _chewieAudioController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((LessonViewModel viewModel) => viewModel.isLoading);

    return isLoading ? LoadingIndicator() : _lesson(context);
  }

  Widget _lesson(BuildContext context) {
    final vm = context.watch<LessonViewModel>();
    final lesson = context.watch<Lesson>();
    final section = context.watch<LessonSection>();
    final lang = context.watch<Lang>();

    if (lesson.audioBytes > 0 &&
        _audioPlayerController == null &&
        _chewieAudioController == null) {
      _audioPlayerController = VideoPlayerController.network(vm.audioUrl);
      _chewieAudioController = ChewieAudioController(
        videoPlayerController: _audioPlayerController,
        autoInitialize: true,
        autoPlay: false,
        looping: true,
      );
    }

    if (lesson.videoBytes > 0 &&
        _videoPlayerController == null &&
        _chewieVideoController == null) {
      _videoPlayerController = VideoPlayerController.network(vm.videoUrl);

      _chewieVideoController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: false,
        looping: true,
        autoInitialize: true,
        routePageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondAnimation, provider) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return VideoScaffold(
                child: Scaffold(
                  resizeToAvoidBottomPadding: false,
                  body: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: provider,
                  ),
                ),
              );
            },
          );
        },
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: (lesson.videoBytes > 0
                ? <Widget>[Chewie(controller: _chewieVideoController)]
                : []) +
            <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  lesson.description,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.justify,
                ),
              ),
            ] +
            (lesson.imageBytes > 0
                ? <Widget>[
                    Container(
                      color: Colors.black,
                      height: 250,
                      child: FullScreenWidget(
                        child: Hero(
                          tag: "smallImage",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              vm.imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                : []) +
            (lesson.audioBytes > 0
                ? <Widget>[
                    ChewieAudio(controller: _chewieAudioController),
                  ]
                : []) +
            (lesson.pdfBytes > 0
                ? <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: PlatformCardButton(
                        child: Text(
                          "PDF",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () async {
                          Navigator.of(context).push(
                            platformPageRoute(
                              context: context,
                              builder: (context) => LessonPdfDialog(
                                lesson: lesson,
                                section: section,
                                lang: lang,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ]
                : []) +
            <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: PlatformCardButton(
                        child: Text(
                          "Грамматика",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () =>
                            Navigator.of(context).push(platformPageRoute(
                          context: context,
                          builder: (context) => LessonPhrasesView(
                            lesson: lesson,
                            section: section,
                            lang: lang,
                          ),
                        )),
                      ),
                    ),
                    Expanded(
                      child: PlatformCardButton(
                        child: Text(
                          "Перейти к тесту",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () =>
                            Navigator.of(context).push(platformPageRoute(
                          context: context,
                          builder: (context) => LessonTestView(
                            lesson: lesson,
                            section: section,
                            lang: lang,
                          ),
                        )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.0),
            ],
      ),
    );
  }
}
