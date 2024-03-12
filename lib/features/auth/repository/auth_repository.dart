import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sewan/core/constants/firebase_constants.dart';
import 'package:sewan/core/errors/firebase_exceptions.dart';
import 'package:sewan/core/models/user_model.dart';
import 'package:sewan/core/providers/firebase_providers.dart';
import 'package:sewan/core/types/failure.dart';
import 'package:sewan/core/types/future_either.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    firestore: ref.watch(firestoreProvider),
    auth: ref.watch(authProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRepository(
      {required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _firestore = firestore,
        _auth = auth;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  String initialPath() {
    if (_auth.currentUser != null) {
      return '/home';
    } else {
      return '/signin';
    }
  }

  FutureEither<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final userId = authResult.user!.uid;

      UserModel userModel =
          UserModel(id: userId, email: email, name: name, points: 0);
      await _users.doc(userId).set(userModel.toMap());

      return Right(userModel);
    } on FirebaseException catch (e) {
      return Left(Failure(handleAuthException(e.code)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signInWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final userId = authResult.user!.uid;

      UserModel userModel = await getUserData(userId);

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(handleAuthException(e.code)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<UserModel> getUserData(String uid) async{
    final user = _users.doc(uid).get();
    final userValue  = await user;
    return UserModel.fromMap(userValue.data() as Map<String, dynamic>);
  }

  FutureVoid updateUserData(UserModel userModel) async {
    try {
      return Right(await _users.doc(userModel.id).update(userModel.toMap()));
    } on FirebaseAuthException catch (e) {
      return Left(Failure(handleAuthException(e.code)));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
