import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:looser_spend_manager/auth/auth_repository.dart';

final authServiceProvider = Provider.autoDispose(
  (ref) => AuthService(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class AuthService {
  AuthService({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Stream<User?> subscribeUser() => _authRepository.subscribeUser();

  Future<UserCredential?> signInAnonymous() async {
    return await _authRepository.signInAnonymously();
  }
}
