import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/firestore_models/expense/expense.dart';
import '../../repository/auth/auth_repository.dart';
import '../../service/expense_service.dart';

/// 現在選択中の DateTime を管理する StateProvider
final selectedDateTimeProvider =
    StateProvider.autoDispose((ref) => DateTime.now());

/// 月毎の [Expense] を購読する StreamProvider
final expensesByMonthStreamProvider =
    StreamProvider.autoDispose<List<Expense>>((ref) {
  final userId = ref.watch(userIdStateProvider);
  final expenseService = ref.watch(expenseServiceProvider);
  final selectedMonth = ref.watch(selectedDateTimeProvider);
  return expenseService.subscribeByMonth(
    userId: userId,
    dateTime: selectedMonth,
  );
});
