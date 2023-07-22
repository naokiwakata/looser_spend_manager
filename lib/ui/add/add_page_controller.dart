import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:looser_spend_manager/domain/firestore_models/expense/expense.dart';
import 'package:looser_spend_manager/service/auth_service.dart';
import 'package:looser_spend_manager/service/expense_service.dart';

import '../../domain/money.dart';

final selectedMoneyStateProvider = StateProvider.autoDispose(
  (ref) => <Money>{},
);

final addPageController = Provider.autoDispose(
  (ref) => AddPageController(
    selectedMoneyController: ref.watch(selectedMoneyStateProvider.notifier),
    expenseService: ref.watch(expenseServiceProvider),
    authService: ref.watch(authServiceProvider),
  ),
);

class AddPageController {
  AddPageController({
    required StateController<Set<Money>> selectedMoneyController,
    required ExpenseService expenseService,
    required AuthService authService,
  })  : _selectedMoneyController = selectedMoneyController,
        _expenseService = expenseService,
        _authService = authService;

  final StateController<Set<Money>> _selectedMoneyController;
  final ExpenseService _expenseService;
  final AuthService _authService;

  void select(Money money) {
    _selectedMoneyController.update((state) => {...state, money});
  }

  void unselect(Money money) {
    _selectedMoneyController
        .update((state) => state.where((item) => item != money).toSet());
  }

  Future<void> add({required int sum}) async {
    _authService.subscribeUser().asBroadcastStream().listen((user) {
      if (user == null) return;
      final expense = Expense(money: sum);
      _expenseService.create(expense: expense, userId: user.uid);
    });
  }
}
