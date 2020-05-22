import 'package:flutter/widgets.dart';
import 'package:prolang/ui/widgets/firebase_image.dart';
import 'package:sliver_fab/sliver_fab.dart';

class LessonFab extends StatelessWidget {
  final List<Widget> slivers;
  final double expandedHeight;
  final double avatarSize;
  final String basePath;

  const LessonFab({
    Key key,
    this.expandedHeight,
    this.slivers,
    this.avatarSize,
    this.basePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = ((MediaQuery.of(context).size.width - avatarSize) / 2);

    return SliverFab(
        floatingWidget: Container(
          height: avatarSize,
          width: avatarSize,
          margin: EdgeInsets.only(left: 7.5),
          child: ClipOval(
            child: FirebaseImage(
              '$basePath/avatar.png',
            ),
          ),
        ),
        floatingPosition: FloatingPosition(
          left: media - 10,
          top: -(avatarSize / 2 - 22),
        ),
        expandedHeight: expandedHeight,
        slivers: slivers);
  }
}
