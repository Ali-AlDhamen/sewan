
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/models/question.dart';
import 'package:sewan/features/quiz/state/quiz_state_controller.dart';
import 'package:sewan/features/quiz/view/widgets/question_card.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizScreenState();
}
class _QuizScreenState extends ConsumerState<QuizScreen> {

  @override
  Widget build(BuildContext context) {
     final quizState = ref.watch(quizStateControllerProvider);
    return Scaffold(

   

      body: Body(questions: quizState.questions),
      
    );
  }
}



class Body extends ConsumerStatefulWidget {
  final List<Question> questions;
  const Body({super.key, required this.questions});

  @override
  ConsumerState<Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<Body> {
  void nextQuestion(BuildContext context, WidgetRef ref) {
    if (mounted) {
      final quizController = ref.read(quizStateControllerProvider.notifier);

      // ignore: invalid_use_of_protected_member
      if (quizController.state.pageController.page!.toInt() ==
          widget.questions.length - 1) {
        context.go('/results');
        return;
      }
      quizController.nextQuestion(widget.questions);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(quizStateControllerProvider.notifier)
          .startQuiz(widget.questions);
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizController = ref.watch(quizStateControllerProvider.notifier);

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
                          "Question ${ref.watch(quizStateControllerProvider).questionNumber +1}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.black).copyWith(fontSize: 30),
                      children: [
                        TextSpan(
                          text: "/${widget.questions.length}",
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

                  // ignore: invalid_use_of_protected_member
                  controller: quizController.state.pageController,
                  itemCount: widget.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                    
                    nextQuestion: () => nextQuestion(context, ref),
                    question: widget.questions[index],
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