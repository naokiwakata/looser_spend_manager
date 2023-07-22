import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/firestore_models/expense/expense.dart';
import '../../domain/money.dart';
import '../../service/expense_service.dart';

final expensesStreamProvider =
    StreamProvider.autoDispose.family<List<Expense>, String>((ref, userId) {
  final expenseService = ref.watch(expenseServiceProvider);
  return expenseService.subscribe(userId);
});

final selectedMoneyStateProvider = StateProvider.autoDispose(
  (ref) => <Money>{},
);

final addPageController = Provider.autoDispose(
  (ref) => AddPageController(
    selectedMoneyController: ref.watch(selectedMoneyStateProvider.notifier),
    expenseService: ref.watch(expenseServiceProvider),
  ),
);

class AddPageController {
  AddPageController({
    required StateController<Set<Money>> selectedMoneyController,
    required ExpenseService expenseService,
  })  : _selectedMoneyController = selectedMoneyController,
        _expenseService = expenseService;

  final StateController<Set<Money>> _selectedMoneyController;
  final ExpenseService _expenseService;

  void select(Money money) {
    _selectedMoneyController.update((state) => {...state, money});
  }

  void unselect(Money money) {
    _selectedMoneyController
        .update((state) => state.where((item) => item != money).toSet());
  }

  Future<void> add({required int sum, required String userId}) async {
    final expense = Expense(money: sum);
    _expenseService.create(expense: expense, userId: userId);

    clear();
  }

  void clear() {
    _selectedMoneyController.update((state) => {});
  }
}
