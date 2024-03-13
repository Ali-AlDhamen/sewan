import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/models/course_model.dart';
import 'package:sewan/core/utils/random_color_generator.dart';

class CourseWidget extends ConsumerWidget {
  final CourseModel course;
  const CourseWidget({super.key, required this.course});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('course screen', pathParameters: {'courseId': '1'});
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
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
                      child: const Icon(Icons.book, color: Colors.white)),
                  const SizedBox(width: 10),
                  Text(
                    course.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    course.lectures.length.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Icon(Icons.book, color: Colors.grey, size: 20),
                ],
              ),
            ],
          )),
    );
  }
}
