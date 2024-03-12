import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlashcardWidget extends ConsumerWidget {
  const FlashcardWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        // border at top
        border: const Border(
          top: BorderSide(
            color: Colors.green,
            width: 5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: Colors.grey),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Text('Twjwebjkewj jwdbiwbe dwbih bew bdwihbwie erm', textAlign: TextAlign.center,),
                    Divider(),
                    Text('lorem ewbbweibwe dwejhhdw xhwbiwbwx xbwihb edhbdwi dhwbhew ehbbdhbwd', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
