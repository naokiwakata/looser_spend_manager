import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider.autoDispose((ref) => AuthRepository());

final userIdStateProvider = StateProvider<String>((ref) => '');

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  /// 匿名認証を行う
  Future<UserCredential?> signInAnonymously() async {
    return await _auth.signInAnonymously();
  }

  /// Userの認証情報を購読する
  Stream<User?> subscribeUser() {
    return _auth.authStateChanges();
  }
}
