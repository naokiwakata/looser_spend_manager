import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_models/app_user/app_user.dart';
import 'firestore_models/expense/expense.dart';

final _db = FirebaseFirestore.instance;

/// appUsers コレクションの参照
final appUsersRef = _db.collection('appUsers').withConverter<AppUser>(
      fromFirestore: (ds, _) {
        return AppUser.fromDocumentSnapshot(ds);
      },
      toFirestore: (obj, _) => obj.toJson(),
    );

/// appUser ドキュメントの参照
DocumentReference<AppUser> appUserRef(String userId) => appUsersRef.doc(userId);

/// appUser.expenses コレクションの参照
CollectionReference<Expense> expensesRef({required String userId}) {
  return appUserRef(userId).collection('expenses').withConverter(
        fromFirestore: (ds, _) {
          return Expense.fromDocumentSnapshot(ds);
        },
        toFirestore: (obj, _) => obj.toJson(),
      );
}

/// appUser.expense ドキュメントの参照
DocumentReference<Expense> expenseRef(
    {required String userId, required String expenseId}) {
  return expensesRef(userId: userId).doc(expenseId);
}
