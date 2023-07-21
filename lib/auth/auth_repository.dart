import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider.autoDispose((ref) => AuthRepository());

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInAnonymously() async {
    return await _auth.signInAnonymously();
  }

  Stream<User?> subscribeUser() {
    return _auth.authStateChanges();
  }
}
