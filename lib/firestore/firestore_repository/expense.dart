import 'package:looser_spend_manager/firestore/firestore_models/expense/expense.dart';
import 'package:looser_spend_manager/firestore/firestore_refs.dart';

class ExpenseRepository {
  /// [Expense] を作成する
  Future<void> create({required String userId, required Expense expense}) =>
      expensesRef(userId: userId).add(expense);

  /// [Expense] を削除する
  Future<void> delete({required String userId, required String expenseId}) =>
      expenseRef(userId: userId, expenseId: expenseId).delete();

  /// 指定した [AppUser] の [Expense] のコレクションを購読する
  Stream<List<Expense>> subscribeExpenses({required String userId}) {
    return expensesRef(userId: userId)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((qs) {
      final result = qs.docs.map((ds) => ds.data()).toList();
      return result;
    });
  }
}
