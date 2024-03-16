import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/models/user_model.dart';
import 'package:sewan/core/providers/firebase_providers.dart';

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return LeaderboardRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class LeaderboardRepository {
  final FirebaseFirestore _firestore;
  LeaderboardRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Stream<List<UserModel>> getTopUser() {
    return _firestore
        .collection('users')
        .orderBy("points", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data());
      }).toList();
    });
  }
}
