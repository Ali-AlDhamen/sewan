import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/models/user_model.dart';
import 'package:sewan/theme/app_colors.dart';


class LeaderBoardItem extends StatelessWidget {
  const LeaderBoardItem({super.key, required this.index, required this.user});
  final UserModel user;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: index == 0
                  ? const Color(0xfffed916)
                  : index == 1
                      ? const Color(0xffa7b1ca)
                      : index == 2
                          ? const Color(0xffd8944a)
                          : AppColors.light.primary,
              width: 1)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
         
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            index == 0
                ? Image.asset(
                    "assets/images/1.png",
                    scale: 20,
                  )
                : index == 1
                    ? Image.asset(
                        "assets/images/2.png",
                        scale: 20,
                      )
                    : index == 2
                        ? Image.asset(
                            "assets/images/3.png",
                            scale: 20,
                          )
                        : Text(
                            (index + 1).toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
            Text(
              user.name,
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              user.points.toString(),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}