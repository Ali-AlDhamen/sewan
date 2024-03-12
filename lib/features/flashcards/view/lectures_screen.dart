

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/features/flashcards/view/widgets/lecture_widget.dart';

class LecturesScreen extends ConsumerWidget {
  const LecturesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lectures'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const LectureWidget();
        },
      ),
    );
  }
}