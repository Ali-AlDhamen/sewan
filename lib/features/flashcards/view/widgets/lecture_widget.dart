import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/constants/assets_constants.dart';
import 'package:sewan/core/models/lecture_model.dart';
import 'package:sewan/core/utils/random_color_generator.dart';

class LectureWidget extends ConsumerWidget {
  final LectureModel lecture;
  const LectureWidget({super.key, required this.lecture});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        context.pushNamed('lecture screen',
            pathParameters: {
              'lectureId': lecture.id,
              'courseId': lecture.courseId,
            });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: width * 0.9,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: randomColorGenerator(),
                  child: const Icon(Icons.book, color: Colors.white),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: width * 0.5,
                  child: Text(
                    lecture.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(lecture.flashCards.length.toString()),
                Image.asset(
                  AssetsConstants.flashcardsIcon,
                  width: 20,
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
