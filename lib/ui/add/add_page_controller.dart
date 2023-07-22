import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/money.dart';

final selectedMoneyStateProvider = StateProvider.autoDispose(
  (ref) => <Money>{},
);

final addPageController = Provider.autoDispose(
  (ref) => AddPageController(
    selectedMoneyController: ref.watch(selectedMoneyStateProvider.notifier),
  ),
);

class AddPageController {
  AddPageController(
      {required StateController<Set<Money>> selectedMoneyController})
      : _selectedMoneyController = selectedMoneyController;
  final StateController<Set<Money>> _selectedMoneyController;

  void select(Money money) {
    _selectedMoneyController.update((state) => {...state, money});
    print(_selectedMoneyController.state);
  }

  void unselect(Money money) {
    _selectedMoneyController
        .update((state) => state.where((item) => item != money).toSet());
    print(_selectedMoneyController.state);
  }

  bool isSelected(Money money) {
    return _selectedMoneyController.state.contains(money);
  }
}
