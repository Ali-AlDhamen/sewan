import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/core/utils/show_toast.dart';
import 'package:sewan/features/quiz/controller/quiz_controller.dart';

class RoomScreen extends ConsumerStatefulWidget {
  final String sessionId;
  const RoomScreen({super.key, required this.sessionId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomScreenState();
}

class _RoomScreenState extends ConsumerState<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room'),
      ),
      body: ref.watch(onlineQuizSessionProvider(widget.sessionId)).when(
            data: (data) {
              print(data.player1Id != '' && data.player2Id != '' );
              if (data.player1Id != '' && data.player2Id != '' ) {
                context.go('/online-quiz/${data.id}');
              }
              return SafeArea(
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: data.id));
                      showToast(
                        context: context,
                        message: 'Session ID copied to clipboard',
                        type: ToastType.success,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: FittedBox(
                        child: Text(
                          'Session ID: ${data.id}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // do same as above for these two
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FittedBox(
                      child: Text(
                        'player1: ${data.player1Id}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: data.player2Id != ''
                        ? FittedBox(
                            child: Text(
                              'player2: ${data.player2Id}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        : Text(
                            'player2: ${data.player2Id}',
                            style: const TextStyle(color: Colors.white),
                          ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        // ref.read(quizControllerProvider.notifier).startQuiz(data.sessionId);
                      },
                      child: const Text('Start Quiz', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ]),
              );
            },
            error: (e, st) => Center(child: Text(e.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
