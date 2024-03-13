import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sewan/core/constants/assets_constants.dart';
import 'package:sewan/core/models/user_model.dart';
import 'package:sewan/features/auth/controller/auth_controller.dart';

class PetScreen extends ConsumerStatefulWidget {
  const PetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PetScreenState();
}

class _PetScreenState extends ConsumerState<PetScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel? user = ref.watch(userProvider);

    return Scaffold(
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
                offset: Offset(0, 3),
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
                      Text("Welcome, ${user?.name}"),
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
                                child:
                                    Image.asset(AssetsConstants.toastFailIcon),
                              ),
                            ],
                          ),
                          16.horizontalSpace,
                          Column(
                            children: [
                              SizedBox(
                                width: 50.w,
                                child: const FittedBox(child: Text("Level 5")),
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
              left: -550,
              top: -150,
              child: SizedBox(
                height: 1.sh,
                width: 1.sw,
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
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.sp, top: 16.sp, right: 16.sp),
                      child: const Row(
                        children: [
                          Text("Your Pet"),
                          Spacer(),
                          Text("Change"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: const Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16.sp, bottom: 8.sp, right: 16.sp),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OptionContainer(
                            text: "Streak",
                          ),
                          OptionContainer(
                            text: "Daily Goals",
                          ),
                          OptionContainer(
                            text: "Study Hours",
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: const Text("Recent Lecture"),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: const Text("Show more"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 70.h,
                              width: 70.w,
                              margin: EdgeInsets.all(8.sp),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Lecture Name"),
                                Text(
                                  "Course Name",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Text("20/30"),
                            Container(
                              height: 30.h,
                              width: 30.w,
                              margin: EdgeInsets.all(8.sp),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
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
    );
  }
}

class OptionContainer extends StatelessWidget {
  const OptionContainer({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 80.w,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Center(
          child: FittedBox(child: Text(text)),
        ),
      ),
    );
  }
}
