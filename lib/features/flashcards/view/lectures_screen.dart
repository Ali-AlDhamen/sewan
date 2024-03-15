import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/utils/get_pdftext.dart';
import 'package:sewan/core/utils/pick_image.dart';
import 'package:sewan/core/utils/show_toast.dart';
import 'package:sewan/features/flashcards/controller/flashcards_controller.dart';
import 'package:sewan/features/flashcards/view/widgets/lecture_widget.dart';

class LecturesScreen extends ConsumerWidget {
  final String courseId;
  final String? courseName;
  const LecturesScreen({super.key, required this.courseId, this.courseName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? courseNameRiv;
    ref.watch(courseLecturesProvider(courseId)).when(
          data: (data) {
            courseNameRiv = data.name;
          },
          error: (e, st) => Center(child: Text(e.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
    return Scaffold(
      appBar: AppBar(
        title: Text(courseNameRiv ?? "Lectures"),
      ),
      body: ref.watch(courseLecturesProvider(courseId)).when(
            data: (data) {
              print(data);
              if (data.lectures.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('No lectures found'),
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return UploadLectureModal(
                                  courseId: courseId,
                                );
                              });
                        },
                        child: const Text('Upload Lecture',
                            style: TextStyle(color: Colors.deepPurple)),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: data.lectures.length,
                itemBuilder: (context, index) {
                  return LectureWidget(lecture: data.lectures[index]);
                },
              );
            },
            error: (e, st) => Center(child: Text(e.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return UploadLectureModal(
                  courseId: courseId,
                );
              });
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UploadLectureModal extends ConsumerStatefulWidget {
  final String courseId;
  const UploadLectureModal({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<UploadLectureModal> createState() => _UploadLectureModalState();
}

class _UploadLectureModalState extends ConsumerState<UploadLectureModal> {
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
    final isLoading = ref.watch(flashCardsControllerProvider).isLoading;
    return Container(
      height: 350,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const SizedBox(),
                    const Text(
                      'Upload Lecture',
                      style: TextStyle(
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
                    onPressed: lecture == null ? null : uploadLecture,
                    child: const Text(
                      'Upload Lecture',
                      style: TextStyle(
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

  void uploadLecture() async {
    final fileText = await getPDFtext(lecture!.path);
    if (fileText == 'Failed to get PDF text.') {
      if (mounted) {
        showToast(
          context: context,
          message: "Failed to get PDF text.",
          type: ToastType.error,
        );
      }
    }

    if (mounted) {
      await ref.read(flashCardsControllerProvider.notifier).uploadLecture(
            context: context,
            courseId: widget.courseId,
            title: lecture!.path.split('/').last,
            fileText: fileText,
          );
      ref.invalidate(courseLecturesProvider(widget.courseId));
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
