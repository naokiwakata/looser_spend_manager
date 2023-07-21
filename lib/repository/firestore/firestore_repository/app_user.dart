import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../firestore_models/app_user/app_user.dart';
import '../firestore_refs.dart';

final appUserRepositoryProvider =
    Provider.autoDispose((ref) => AppUserRepository());

class AppUserRepository {
  /// [AppUser] を作成する
  Future<void> create({required AppUser appUser}) => appUsersRef.add(appUser);
}
