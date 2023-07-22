import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:looser_spend_manager/domain/firestore_models/expense/expense.dart';
import 'package:looser_spend_manager/repository/firestore/firestore_repository/expense.dart';

final expenseServiceProvider = Provider.autoDispose(
  (ref) => ExpenseService(
    repository: ref.watch(expenseRepositoryProvider),
  ),
);

class ExpenseService {
  ExpenseService({required ExpenseRepository repository})
      : _repository = repository;

  final ExpenseRepository _repository;

  Future<void> create({
    required Expense expense,
    required String userId,
  }) async {
    _repository.create(
      userId: userId,
      expense: expense,
    );
  }

  Stream<List<Expense>> subscribe(String userId) {
    return _repository.subscribeExpenses(userId: userId);
  }

  Stream<List<Expense>> subscribeByMonth(
      {required String userId, required DateTime dateTime}) {
    return _repository.subscribeExpensesByMonth(userId: userId, date: dateTime);
  }
}
