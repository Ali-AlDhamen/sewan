import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/features/flashcards/controller/flashcards_controller.dart';
import 'package:sewan/features/flashcards/view/widgets/lecture_widget.dart';

class LecturesScreen extends ConsumerWidget {
  final String courseId;
  const LecturesScreen({super.key, required this.courseId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Name'),
      ),
      body: ref.watch(courseLecturesProvider(courseId)).when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return LectureWidget(lecture: data[index]);
            },
          );
        },
        error: (e, st) => Center(child: Text(e.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
