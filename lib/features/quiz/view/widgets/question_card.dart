import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/question.dart';
import 'package:sewan/features/quiz/state/quiz_state_controller.dart';

class QuestionCard extends ConsumerStatefulWidget {
  final VoidCallback nextQuestion;

  const QuestionCard({
    super.key,
    required this.nextQuestion,
    required this.question,
  });

  final Question question;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionCardState();
}

class _QuestionCardState extends ConsumerState<QuestionCard> {
  bool isAnswered = false;

  void checkAnswered() {
    //     setState(() {
    //       isAnswered = true;
    //     });

    Future.delayed(const Duration(seconds: 2), () {
      widget.nextQuestion();
    });
  }

  Timer? _questionTimer;
  @override
  void initState() {
    super.initState();
    _startQuestionTimer();
  }

  void nextQuestion() {
    ref
        .read(quizStateControllerProvider.notifier)
        .submitAnswer(widget.question, '');
    widget.nextQuestion();
  }
  int _remainingTime =  30;
  void _startQuestionTimer() {
   _remainingTime = ref.read(quizStateControllerProvider).timer;
  _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (_remainingTime > 0) {
      setState(() {
        _remainingTime--;
      });
    } else {
      nextQuestion();
      timer.cancel();
    }
  });
  }

  @override
  void dispose() {
    _questionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              '${widget.question.question} ($_remainingTime secs)',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 10),
            ...List.generate(
              widget.question.choices.length,
              (index) => Option(
                question: widget.question,
                index: index,
                text: widget.question.choices[index],
                press: checkAnswered,
                isCorrect:
                    widget.question.answer == widget.question.choices[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Option extends ConsumerStatefulWidget {
  final String text;
  final int index;
  final VoidCallback press;
  final bool isCorrect;
  final Question question;

  const Option({
    super.key,
    required this.text,
    required this.index,
    required this.press,
    required this.isCorrect,
    required this.question,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OptionState();
}

class _OptionState extends ConsumerState<Option> {
  Color getTheRightColor() {
    if (ref.watch(quizStateControllerProvider).answered) {
      if (widget.isCorrect) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
    return Colors.black;
  }

  IconData getTheRightIcon() {
    return getTheRightColor() == Colors.red ? Icons.close : Icons.done;
  }

  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getTheRightColor() != Colors.black
          ? null
          : () {
              ref
                  .read(quizStateControllerProvider.notifier)
                  .submitAnswer(widget.question, widget.text);
              widget.press();
            },
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.text,
                style: TextStyle(color: getTheRightColor(), fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: getTheRightColor() == Colors.black
                    ? Colors.transparent
                    : getTheRightColor(),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: getTheRightColor()),
              ),
              child: getTheRightColor() == Colors.black
                  ? null
                  : Icon(getTheRightIcon(), size: 16),
            )
          ],
        ),
      ),
    );
  }
}
