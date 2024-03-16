import 'dart:io';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/utils/pick_image.dart';
import 'package:sewan/features/flashcards/controller/flashcards_controller.dart';
import 'package:sewan/features/flashcards/view/widgets/course_widget.dart';

class CoursesScreen extends ConsumerStatefulWidget {
  const CoursesScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends ConsumerState<CoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: ref.watch(userCoursesProvider).when(
            data: (courses) {
              if (courses.isEmpty) {
                return const Center(
                  child: Text('No courses found'),
                );
              }
              return ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return CourseWidget(course: courses[index]);
                },
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, st) => Center(
              child: Text(e.toString()),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const CreateCourseModal();
              });
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateCourseModal extends ConsumerStatefulWidget {
  const CreateCourseModal({
    super.key,
  });

  @override
  ConsumerState<CreateCourseModal> createState() => _CreateCourseModalState();
}

class _CreateCourseModalState extends ConsumerState<CreateCourseModal> {
  int value = 0;
  int selectedCourse = 0;
  final TextEditingController courseTitleController = TextEditingController();

  Color colorBuilder(int i) {
    if (i == value) {
      return Colors.deepPurple;
    } else {
      return Colors.grey;
    }
  }

  File? lecture;

  void selectFile() async {
    final selectedFile = await pickFile();
    if (selectedFile != null) {
      setState(() {
        lecture = File(selectedFile.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: value == 0 ? 350 : 550,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const SizedBox(),
              Text(
                value == 0 ? 'Create New Course' : 'Upload Lecture',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 10,
            ),
            child: AnimatedToggleSwitch<int>.size(
              current: value,
              values: const [0, 1],
              iconOpacity: 0.2,
              indicatorSize: const Size.fromWidth(200),
              iconBuilder: (i) => Icon(
                Icons.book,
                color: value == i ? Colors.white : Colors.black,
              ),
              borderWidth: 4.0,
              iconAnimationType: AnimationType.onHover,
              style: ToggleStyle(
                borderColor: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1.5),
                  ),
                ],
              ),
              styleBuilder: (i) => ToggleStyle(indicatorColor: colorBuilder(i)),
              onChanged: (i) => setState(() => value = i),
            ),
          ),
          value == 0
              ? Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: TextField(
                    controller: courseTitleController,
                    cursorColor: Colors.deepPurple,
                    decoration: InputDecoration(
                      hintText: 'Course title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: Text(
                          'Select Lecture',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: selectFile,
                        child: Text(
                          lecture == null
                              ? 'Select File'
                              : lecture!.path.split('/').last,
                          style: const TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          if (value == 1)
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    child: Text(
                      'Select Course',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: DropdownButtonFormField(
                    elevation: 0,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    decoration: InputDecoration(
                      hintText: 'Select Course',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 0,
                        child: SizedBox(
                          width: 300,
                          child: Text(
                            'New Course (${lecture != null ? lecture!.path.split('/').last : ''})',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const DropdownMenuItem(
                        value: 1,
                        child: Text('Course 1'),
                      ),
                      const DropdownMenuItem(
                        value: 2,
                        child: Text('Course 2'),
                      ),
                    ],
                    value: selectedCourse,
                    onChanged: (value) {
                      setState(() {
                        selectedCourse = value as int;
                      });
                    },
                  ),
                ),
              ],
            ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 10,
            ),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton(
              onPressed: () {
                if (value == 0) {
                  createCourse();
                } else {}
              },
              child: Text(
                value == 0 ? 'Create Course' : 'Upload Lecture',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createCourse() {
    ref.read(flashCardsControllerProvider.notifier).createCourse(
          context: context,
          name: courseTitleController.text.trim(),
        );

    Navigator.pop(context);
    ref.invalidate(userCoursesProvider);
  }
}
