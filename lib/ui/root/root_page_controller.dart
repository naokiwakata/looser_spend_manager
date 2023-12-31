import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../service/app_user_service.dart';
import '../../service/auth_service.dart';

final authUserStreamProvider = StreamProvider.autoDispose((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.subscribeUser();
});

final rootControllerProvider = Provider.autoDispose(
  (ref) => RootController(
    authService: ref.watch(authServiceProvider),
    appUserService: ref.watch(appUserServiceProvider),
  ),
);

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
    final user = await _appUserService.fetch(userId);
    if (user == null) {
      await _appUserService.create(userId);
    }
  }
}
