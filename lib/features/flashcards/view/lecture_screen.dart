import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/models/flashcard_model.dart';
import 'package:sewan/core/models/get_lecture_params.dart';
import 'package:sewan/core/models/lecture_model.dart';
import 'package:sewan/features/auth/controller/auth_controller.dart';
import 'package:sewan/features/flashcards/controller/flashcards_controller.dart';
import 'package:sewan/features/flashcards/state/flashcard_learning_state_controller.dart';
import 'package:sewan/features/flashcards/view/widgets/flashcard_widget.dart';

class LectureScreen extends ConsumerStatefulWidget {
  final String lectureId;
  final String courseId;
  const LectureScreen(
      {super.key, required this.lectureId, required this.courseId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LectureScreenState();
}

class _LectureScreenState extends ConsumerState<LectureScreen> {
  final List<String> categories = ['Mastered', 'Need Review', 'Not Started'];
  List<String> selectedCategories = [];

  void setCategories(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(lectureProvider(GetLectureParams(
            courseId: widget.courseId, lectureId: widget.lectureId)))
        .when(
          data: (lecture) {
            int mastered = 0;
            int needReview = 0;
            int notStarted = 0;
            for (var flashCard in lecture.flashCards) {
              if (flashCard.status == FlashCardStatus.completed) {
                mastered++;
              } else if (flashCard.status == FlashCardStatus.notCompleted) {
                needReview++;
              } else {
                notStarted++;
              }
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('Lecture title'),
              ),
              body: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Mastered'),
                            Text(mastered.toString(),
                                style: const TextStyle(color: Colors.green)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Need Review'),
                            Text(needReview.toString(),
                                style: const TextStyle(color: Colors.red)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Not Started'),
                            Text(notStarted.toString(),
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setCategories('Mastered');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: selectedCategories.contains('Mastered')
                                ? Border.all(color: Colors.green, width: 2)
                                : null,
                          ),
                          child: Text('Mastered',
                              style: TextStyle(
                                  color: selectedCategories.contains('Mastered')
                                      ? Colors.green
                                      : Colors.black26)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setCategories('Need Review');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: selectedCategories.contains('Need Review')
                                ? Border.all(color: Colors.red, width: 2)
                                : null,
                          ),
                          child: Text('Need Review',
                              style: TextStyle(
                                  color:
                                      selectedCategories.contains('Need Review')
                                          ? Colors.red
                                          : Colors.black26)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setCategories('Not Started');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: selectedCategories.contains('Not Started')
                                ? Border.all(color: Colors.grey, width: 2)
                                : null,
                          ),
                          child: Text('Not Started',
                              style: TextStyle(
                                  color:
                                      selectedCategories.contains('Not Started')
                                          ? Colors.grey
                                          : Colors.black26)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: lecture.flashCards.length,
                      itemBuilder: (context, index) {
                        return FlashcardWidget(
                            flashCard: lecture.flashCards[index]);
                      },
                    ),
                  )
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 56.0,
                child: Material(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            child: SizedBox(
                              height: 300.h,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // toggle switch for study mode
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Study Mode",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Switch(
                                        value: true,
                                        onChanged: (value) {},
                                        activeColor: Colors.deepPurple,
                                      ),
                                    ],
                                  ),

                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        PurpleLearnButton(
                                          ref: ref,
                                          lecture: lecture,
                                          text: 'Learn By Flashcards',
                                          onPressed: () {
                                            ref
                                                .read(
                                                    flashCardsLearningStateControllerProvider
                                                        .notifier)
                                                .startLearning(
                                                  flashCards:
                                                      lecture.flashCards,
                                                  courseId: lecture.courseId,
                                                  lectureId: lecture.id,
                                                  userId: ref
                                                          .read(userProvider)
                                                          ?.id ??
                                                      '',
                                                );
                                          },
                                        ),
                                        PurpleLearnButton(
                                          ref: ref,
                                          lecture: lecture,
                                          text: 'Teach Me',
                                          onPressed: () {
                                            // TODO: Teach me
                                          },
                                        ),
                                        PurpleLearnButton(
                                          ref: ref,
                                          lecture: lecture,
                                          text: 'Test Me',
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: const Center(
                      child: Text(
                        'Start Lecture',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => Scaffold(
            body: const Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => Scaffold(
            body: Center(
              child: Text(error.toString()),
            ),
          ),
        );
  }
}

class PurpleLearnButton extends StatelessWidget {
  const PurpleLearnButton({
    super.key,
    required this.ref,
    required this.lecture,
    required this.text,
    required this.onPressed,
  });

  final WidgetRef ref;
  final LectureModel lecture;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 40),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
