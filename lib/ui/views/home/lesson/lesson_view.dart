import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:prolang/app/constants/theme_colors.dart';
import 'package:prolang/app/helpers/app_bar_shape.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:prolang/app/models/lesson.dart';
import 'package:prolang/app/models/lesson_section.dart';
import 'package:prolang/ui/views/home/lesson/lesson_view_model.dart';
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
  ChewieController _chewieController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
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

    if (_videoPlayerController == null && _chewieController == null) {
      _videoPlayerController = VideoPlayerController.network(vm.videoUrl);
      _chewieController = ChewieController(
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

    return CustomScrollView(
      slivers: <Widget>[
        SliverStickyHeader(
          header: Chewie(controller: _chewieController),
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    lesson.description,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 16.0),
                  Row(
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
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
