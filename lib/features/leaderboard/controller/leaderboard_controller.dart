import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/user_model.dart';
import 'package:sewan/features/leaderboard/repository/leaderboard_repository.dart';

final leaderboardControllerProvider =
    StateNotifierProvider<LeaderboardController, AsyncValue<void>>((ref) {
  return LeaderboardController(
    leaderboardRepository: ref.watch(leaderboardRepositoryProvider),
    ref: ref,
  );
});

final leaderboardProvider = StreamProvider<List<UserModel>>((ref) {
  final leaderboardController =
      ref.watch(leaderboardControllerProvider.notifier);
  return leaderboardController.getLeaderboard();
});

class LeaderboardController extends StateNotifier<AsyncValue<void>> {
  final LeaderboardRepository _leaderboardRepository;
  final Ref _ref;
  LeaderboardController({
    required LeaderboardRepository leaderboardRepository,
    required Ref ref,
  })  : _leaderboardRepository = leaderboardRepository,
        _ref = ref,
        super(const AsyncValue.data(null));

  Stream<List<UserModel>> getLeaderboard() {
    final result = _leaderboardRepository.getTopUser();
    return result;
  }
}
