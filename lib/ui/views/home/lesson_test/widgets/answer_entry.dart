import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/ui/widgets/platform_card.dart';
import 'package:prolang/ui/widgets/platform_card_button.dart';

class AnswerEntry extends StatefulWidget {
  final String answer;
  final Function(bool) onPressed;

  const AnswerEntry(
    this.answer, {
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  AnswerEntryState createState() => AnswerEntryState();
}

class AnswerEntryState extends State<AnswerEntry>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  toggle() {
    if (_selected == false && _animation.status == AnimationStatus.dismissed) {
      _controller.forward();
      _selected = true;
    } else if (_selected == true &&
        _animation.status == AnimationStatus.completed) {
      _controller.reverse();
      _selected = false;
    }
    widget.onPressed(_selected);
  }

  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300));
    Tween tween = Tween<double>(begin: 0, end: 1);
    _animation = tween.animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(_animation.value * 0.4),
                blurRadius: _animation.value * 5,
              ),
            ],
          ),
          child: PlatformCardButton(
            onPressed: toggle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  widget.answer,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
