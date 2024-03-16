import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sewan/core/constants/assets_constants.dart';
import 'package:sewan/core/models/user_model.dart';
import 'package:sewan/features/auth/controller/auth_controller.dart';
import 'package:sewan/features/flashcards/controller/flashcards_controller.dart';
import 'package:sewan/features/flashcards/view/widgets/course_widget.dart';
import 'package:sewan/features/quiz/controller/quiz_controller.dart';
import 'package:sewan/theme/app_colors.dart';

class PetScreen extends ConsumerStatefulWidget {
  const PetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PetScreenState();
}

class _PetScreenState extends ConsumerState<PetScreen> {
  final TextEditingController _roomIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserModel? user = ref.watch(userProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome, ${user?.name ?? ""}"),
                        8.verticalSpace,
                        Row(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 40.h,
                                  width: 40.w,
                                  child: const CircularProgressIndicator(
                                    value: 0.75,
                                  ),
                                ),
                                Container(
                                  height: 40.h,
                                  width: 40.w,
                                  padding: EdgeInsets.all(2.sp),
                                  // CHANGE TO PROFILE IMAGE
                                  child: const Icon(Icons.person),
                                ),
                              ],
                            ),
                            16.horizontalSpace,
                            Column(
                              children: [
                                SizedBox(
                                  width: 50.w,
                                  child:
                                      const FittedBox(child: Text("Level 5")),
                                ),
                                SizedBox(
                                  width: 50.w,
                                  child:
                                      const FittedBox(child: Text("1000/2000")),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SizedBox(
          width: 1.sw,
          child: Stack(
            children: [
              Positioned(
                left: -70,
                top: -130,
                child: SizedBox(
                  height: 0.65.sh,
                  width: 0.65.sw,
                  child: Lottie.asset(
                    AssetsConstants.petAnimation,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 0.35.sh,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.sp,
                          bottom: 8.sp,
                          right: 16.sp,
                          top: 16.sp,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OptionContainer(
                              text: "5 🔥",
                            ),
                            OptionContainer(
                              text: "10\nDaily Hours",
                            ),
                            OptionContainer(
                              text: "200\nTotal Hours",
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: const Text("Recent Courses"),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: const Text("Show more"),
                          ),
                        ],
                      ),
                      ref.watch(userCoursesProvider).when(
                            data: (data) {
                              if (data.isNotEmpty) {
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        data.length > 1 ? 2 : data.length,
                                    itemBuilder: (context, index) {
                                      return CourseWidget(
                                        course: data[index],
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (error, stack) => Center(
                              child: Text(
                                error.toString(),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 400.h,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(16.sp),
                        width: double.infinity,
                        child: TextField(
                          controller: _roomIdController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter Room ID",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16.sp),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                          ),
                          onPressed: () {
                            ref
                                .read(quizControllerProvider.notifier)
                                .joinOnlineQuizSession(
                                  context: context,
                                  sessionId: _roomIdController.text,
                                );
                          },
                          child: const Text(
                            'Join Room',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class OptionContainer extends StatelessWidget {
  const OptionContainer({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColors.light.primary,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Center(
          child: FittedBox(
              child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
      ),
    );
  }
}
