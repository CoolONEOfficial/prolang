import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prolang/ui/widgets/platform_card.dart';
import 'package:prolang/ui/widgets/platform_card_button.dart';

class TestResults extends StatelessWidget {
  final List<bool> answers;
  final Function onRestart;
  final Function onNext;

  const TestResults(
    this.answers, {
    Key key,
    this.onRestart,
    this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final correctAnswers = answers.where((correct) => correct);
    final pass = correctAnswers.length >= answers.length / 3 * 2;
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  pass
                      ? "Вы прошли этот тест!"
                      : "К сожалению,\nВы не прошли этот тест",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                Text.rich(
                  TextSpan(
                    text: "Вы набрали\n",
                    style: Theme.of(context).textTheme.headline5,
                    children: [
                      TextSpan(
                        text: '${correctAnswers.length}/${answers.length}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      TextSpan(
                        text: '\nправильных ответов',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: PlatformCardButton(
                  child: Text(
                    "Заново",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: onRestart,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: PlatformCardButton(
                  enabled: pass,
                  child: Text(
                    "Дальше",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: onNext,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}
