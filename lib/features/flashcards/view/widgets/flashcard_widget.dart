import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/flashcard_model.dart';

class FlashcardWidget extends ConsumerWidget {
  final FlashCardModel flashCard;
  const FlashcardWidget({super.key, required this.flashCard});

  Color getStatusColor(FlashCardStatus status) {
    switch (status) {
      case FlashCardStatus.completed:
        return Colors.green;
      case FlashCardStatus.notCompleted:
        return Colors.red;
      case FlashCardStatus.notStarted:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

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
        border: Border(
          top: BorderSide(
            color: getStatusColor(flashCard.status),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      flashCard.term,
                      textAlign: TextAlign.center,
                    ),
                    const Divider(),
                    Text(flashCard.definition, textAlign: TextAlign.center),
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
