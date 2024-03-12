import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/features/flashcards/view/widgets/flashcard_widget.dart';

class LectureScreen extends ConsumerStatefulWidget {
  const LectureScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LectureScreenState();
}

class _LectureScreenState extends ConsumerState<LectureScreen> {
  final List<String> categories = ['Mastered', 'Need Review', 'Not Started'];
  List<String> selectedCategories = [];

  void setCategories(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecture title'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Mastered'),
                    Text('10', style: TextStyle(color: Colors.green)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Need Review'),
                    Text('10', style: TextStyle(color: Colors.red)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Not Started'),
                    Text('10', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setCategories('Mastered');
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: selectedCategories.contains('Mastered')
                        ? Border.all(color: Colors.green, width: 2)
                        : null,
                  ),
                  child: Text('Mastered',
                      style: TextStyle(
                          color: selectedCategories.contains('Mastered')
                              ? Colors.green
                              : Colors.black26)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setCategories('Need Review');
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: selectedCategories.contains('Need Review')
                        ? Border.all(color: Colors.red, width: 2)
                        : null,
                  ),
                  child: Text('Need Review',
                      style: TextStyle(
                          color: selectedCategories.contains('Need Review')
                              ? Colors.red
                              : Colors.black26)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setCategories('Not Started');
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: selectedCategories.contains('Not Started')
                        ? Border.all(color: Colors.grey, width: 2)
                        : null,
                  ),
                  child: Text('Not Started',
                      style: TextStyle(
                          color: selectedCategories.contains('Not Started')
                              ? Colors.grey
                              : Colors.black26)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const FlashcardWidget(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 56.0,
        child: Material(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        height: 250,
                        child: Column(
                          children: [
                            // toggle switch for study mode
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Study Mode",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Switch(
                                  value: true,
                                  onChanged: (value) {},
                                  activeColor: Colors.deepPurple,
                                ),
                              ],
                            ),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  context.pushNamed('Flashcards session',
                                      pathParameters: {'sessionId': '1'});
                                },
                                child: Text(
                                  "Learn by Flashcards",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Learn by Quiz",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Text(
                'Start Lecture',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
