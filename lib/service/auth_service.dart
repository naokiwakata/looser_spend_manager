import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:looser_spend_manager/repository/auth/auth_repository.dart';

final authServiceProvider = Provider.autoDispose(
  (ref) => AuthService(
    repository: ref.watch(authRepositoryProvider),
  ),
);

class AuthService {
  AuthService({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  Stream<User?> subscribeUser() => _repository.subscribeUser();

  Future<UserCredential?> signInAnonymous() async {
    return await _repository.signInAnonymously();
  }
}
