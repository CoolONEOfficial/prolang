import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prolang/app/models/lang.dart';
import 'package:provider/provider.dart';

import 'lesson_list_view_model.dart';

class LessonListView extends StatelessWidget {
  const LessonListView(
    this.lang, {
    Key key,
  }) : super(key: key);

  final Lang lang;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LessonListViewModel>(
      create: (_) => LessonListViewModel(context.read, lang),
      builder: (_, child) {
        return PlatformScaffold(
          body: LessonListViewBody._(),
        );
      },
    );
  }
}

class LessonListViewBody extends StatelessWidget {
  const LessonListViewBody._({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
