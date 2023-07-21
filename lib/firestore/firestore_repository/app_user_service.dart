import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:looser_spend_manager/firestore/firestore_models/app_user/app_user.dart';
import 'package:looser_spend_manager/firestore/firestore_repository/app_user.dart';

final appUserServiceProvider = Provider.autoDispose(
  (ref) => AppUserService(
    repository: ref.watch(appUserRepositoryProvider),
  ),
);

class AppUserService {
  AppUserService({required AppUserRepository repository})
      : _repository = repository;

  final AppUserRepository _repository;

  Future<void> create(String userId) async {
    final appUser = AppUser(userId: userId);
    _repository.create(appUser: appUser);
  }
}
