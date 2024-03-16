import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/models/question.dart';
import 'package:sewan/features/quiz/controller/quiz_controller.dart';
import 'package:sewan/features/quiz/state/online_quiz_session.dart';
import 'package:sewan/features/quiz/state/quiz_state_controller.dart';
import 'package:sewan/features/quiz/view/widgets/online_question_card.dart';
import 'package:sewan/features/quiz/view/widgets/question_card.dart';

class OnlineQuizScreen extends ConsumerStatefulWidget {
  final String sessionId;
  const OnlineQuizScreen({super.key, required this.sessionId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnlineQuizScreenState();
}

class _OnlineQuizScreenState extends ConsumerState<OnlineQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(onlineQuizSessionProvider(widget.sessionId)).when(
            data: (session) {
              return Body(session: session);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
          ),
    );
  }
}

class Body extends ConsumerStatefulWidget {
  final OnlineQuizSession session;
  const Body({super.key, required this.session});

  @override
  ConsumerState<Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<Body> {
  final PageController pageController = PageController();
  void nextQuestion(BuildContext context, WidgetRef ref) {
    if (mounted) {
      if (pageController.page!.toInt() == widget.session.questions.length - 1) {
        context.go('/results');
        return;
      }
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
      );
      ref
          .read(quizControllerProvider.notifier)
          .nextQuestion(context: context, sessionId: widget.session.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    final length1 = widget.session.player1Answers.length;
    final length2 = widget.session.player2Answers.length;
  print("length1: $length1 + length2: $length2, currentQuestionIndex: ${widget.session.currentQuestionIndex}");
  print(length1 != widget.session.currentQuestionIndex);
  print(length1 == length2);
     WidgetsBinding.instance.addPostFrameCallback((_) {
      if (length1 != widget.session.currentQuestionIndex &&
          length1 == length2 ) {
        print("here");
        nextQuestion(context, ref);
      }
    });
    
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text.rich(
                    TextSpan(
                      text:
                          "Question ${widget.session.currentQuestionIndex + 1}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.black)
                          .copyWith(fontSize: 30),
                      children: [
                        TextSpan(
                          text: "/${widget.session.questions.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  )),
              const Divider(thickness: 1.5, color: Colors.black),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: widget.session.questions.length,
                  itemBuilder: (context, index) => OnlineQuestionCard(
                    session: widget.session,
                    nextQuestion: () => nextQuestion(context, ref),
                    question: widget.session.questions[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
