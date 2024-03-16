import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/flashcard_model.dart';
import 'package:sewan/features/flashcards/state/flashcard_learning_state_controller.dart';

class FlashCardLearning extends ConsumerWidget {
  const FlashCardLearning({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(flashCardsLearningStateControllerProvider);
    print(state.clicked);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                text: state.currentIndex.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '/${state.flashCards.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(5),
            child: LinearProgressIndicator(
              value: state.currentIndex / state.flashCards.length,
              backgroundColor: Colors.grey.withOpacity(0.5),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(flashCardsLearningStateControllerProvider.notifier)
                      .show();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        state.flashCards[state.currentIndex].term,
                        textAlign: TextAlign.center,
                      ),
                      const Divider(),
                      AnimatedOpacity(
                        opacity: state.clicked ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          state.flashCards[state.currentIndex].definition,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.green,
                      disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                    ),
                    onPressed: !state.clicked
                        ? null
                        : () {
                            ref
                                .read(flashCardsLearningStateControllerProvider
                                    .notifier)
                                .changeFlashCardStatus(
                                  flashcard:
                                      state.flashCards[state.currentIndex],
                                  status: FlashCardStatus.completed,
                                );
                          },
                    child: const Text('Mastered',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.red,
                      disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                    ),
                    onPressed: !state.clicked
                        ? null
                        : () {
                            ref
                                .read(flashCardsLearningStateControllerProvider
                                    .notifier)
                                .changeFlashCardStatus(
                                  flashcard:
                                      state.flashCards[state.currentIndex],
                                  status: FlashCardStatus.notCompleted,
                                );
                          },
                    child: const Text('Need Review',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
