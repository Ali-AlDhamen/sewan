import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/user_model.dart';
import 'package:sewan/core/providers/storage_provider.dart';
import 'package:sewan/features/auth/repository/auth_repository.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<void>>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    storageRepository: ref.watch(storageRepositoryProvider),
    ref: ref,
  ),
);

final getUserDataProvider =
    FutureProvider.family.autoDispose<UserModel, String>((ref, uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final authStateChangeProvider = StreamProvider.autoDispose<User?>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;
  final StorageRepository _storageRepository;
  final Ref _ref;
  AuthController(
      {required AuthRepository authRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _authRepository = authRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(const AsyncData(null));

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Future<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  String initialPath() {
    return _authRepository.initialPath();
  }

  void signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncLoading();
    final user = await _authRepository.signUpWithEmail(
        email: email, password: password, name: name);
    user.fold((l) {
      state = AsyncError(l.message, StackTrace.empty);
    }, (userModel) {
      _ref.read(userProvider.notifier).update((state) => userModel);
    });

    state = const AsyncData(null);
  }

  void signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final user =
        await _authRepository.signInWithEmail(email: email, password: password);

    user.fold(
      (l) {
        state = AsyncError(l.message, StackTrace.empty);
      },
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
    state = const AsyncData(null);
  }



  void signOut() {
    _authRepository.signOut();
    _ref.read(userProvider.notifier).update((state) => null);
  }
}
