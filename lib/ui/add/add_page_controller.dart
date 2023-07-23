import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:looser_spend_manager/repository/auth/auth_repository.dart';

import '../../domain/firestore_models/expense/expense.dart';
import '../../domain/money.dart';
import '../../service/expense_service.dart';

final expensesStreamProvider = StreamProvider.autoDispose<List<Expense>>((ref) {
  final userId = ref.watch(userIdStateProvider);
  final expenseService = ref.watch(expenseServiceProvider);
  return expenseService.subscribe(userId);
});

final expensesByMonthStreamProvider =
    StreamProvider.autoDispose<List<Expense>>((ref) {
  final userId = ref.watch(userIdStateProvider);
  final expenseService = ref.watch(expenseServiceProvider);
  final selectedMonth = ref.watch(selectedMonthProvider);
  return expenseService.subscribeByMonth(
    userId: userId,
    dateTime: selectedMonth,
  );
});

final selectedMonthProvider =
    StateProvider.autoDispose((ref) => DateTime.now());

final selectedMoneyStateProvider = StateProvider.autoDispose(
  (ref) => <Money>{},
);

final addPageController = Provider.autoDispose(
  (ref) => AddPageController(
    selectedMoneyController: ref.watch(selectedMoneyStateProvider.notifier),
    expenseService: ref.watch(expenseServiceProvider),
    userId: ref.watch(userIdStateProvider),
  ),
);

class AddPageController {
  AddPageController({
    required StateController<Set<Money>> selectedMoneyController,
    required ExpenseService expenseService,
    required String userId,
  })  : _selectedMoneyController = selectedMoneyController,
        _expenseService = expenseService,
        _userId = userId;

  final StateController<Set<Money>> _selectedMoneyController;
  final ExpenseService _expenseService;
  final String _userId;

  void select(Money money) {
    _selectedMoneyController.update((state) => {...state, money});
  }

  void unselect(Money money) {
    _selectedMoneyController
        .update((state) => state.where((item) => item != money).toSet());
  }

  Future<void> add({required int sum}) async {
    final expense = Expense(money: sum);
    _expenseService.create(expense: expense, userId: _userId);

    clear();
  }

  void clear() {
    _selectedMoneyController.update((state) => {});
  }
}
