import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:looser_spend_manager/firestore/firestore_repository/app_user_service.dart';

import '../../auth/auth_service.dart';

final authUserStreamProvider = StreamProvider.autoDispose((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.subscribeUser();
});

final rootControllerProvider = Provider.autoDispose((ref) => RootController(
    authService: ref.watch(authServiceProvider),
    appUserService: ref.watch(appUserServiceProvider)));

class RootController {
  RootController(
      {required AuthService authService,
      required AppUserService appUserService})
      : _authService = authService,
        _appUserService = appUserService;

  final AuthService _authService;
  final AppUserService _appUserService;

  Future<void> signIn() async {
    await _authService.signInAnonymous();
  }

  Future<void> createUser(String userId) async {
    await _appUserService.create(userId);
  }
}
