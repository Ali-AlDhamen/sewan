// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final Color? color;
  const LoaderWidget({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).primaryColor
        ),
      ),
    );
  }
}
