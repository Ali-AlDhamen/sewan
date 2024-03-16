import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/question.dart';
import 'package:sewan/features/auth/controller/auth_controller.dart';
import 'package:sewan/features/quiz/controller/quiz_controller.dart';
import 'package:sewan/features/quiz/state/online_quiz_session.dart';
import 'package:sewan/features/quiz/state/quiz_state_controller.dart';

class OnlineQuestionCard extends ConsumerStatefulWidget {
  final OnlineQuizSession session;
  final VoidCallback nextQuestion;

  const OnlineQuestionCard(
      {super.key,
      required this.nextQuestion,
      required this.question,
      required this.session});

  final Question question;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnlineQuestionCardState();
}

class _OnlineQuestionCardState extends ConsumerState<OnlineQuestionCard> {
  bool isAnswered = false;

  void checkAnswered() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Check if the widget is still part of the tree
        widget.nextQuestion();
      }
    });
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
              '${widget.question.question}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 10),
            ...List.generate(
              widget.question.choices.length,
              (index) => Option(
                session: widget.session,
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
  final OnlineQuizSession session;

  const Option(
      {super.key,
      required this.text,
      required this.index,
      required this.press,
      required this.isCorrect,
      required this.question,
      required this.session});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OptionState();
}

class _OptionState extends ConsumerState<Option> {
  Color getTheRightColor() {
    final length1 = widget.session.player1Answers.length;
    final length2 = widget.session.player2Answers.length;

    if (length1 != widget.session.currentQuestionIndex && length1 == length2) {
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
              final userId = ref.read(userProvider)?.id ?? '';
              int playerId = widget.session.player1Id == userId ? 1 : 2;

              ref.read(quizControllerProvider.notifier).submitAnswer(
                    context: context,
                    sessionId: widget.session.id,
                    questionId: widget.question.id,
                    answer: widget.text,
                    playerId: playerId,
                  );
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
