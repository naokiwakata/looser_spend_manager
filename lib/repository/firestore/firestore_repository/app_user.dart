import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../firestore_models/app_user/app_user.dart';
import '../firestore_refs.dart';

final appUserRepositoryProvider =
    Provider.autoDispose((ref) => AppUserRepository());

class AppUserRepository {
  /// [AppUser] を作成する
  Future<void> create({required AppUser appUser}) =>
      appUsersRef.doc(appUser.userId).set(appUser);

  Future<AppUser?> fetch({required String userId}) async {
    final ds = await appUserRef(userId).get();
    return ds.data();
  }
}
