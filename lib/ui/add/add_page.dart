import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/money.dart';
import '../../extension/iterable.dart';
import '../root/root_page_controller.dart';
import 'add_page_controller.dart';

@RoutePage()
class AddPage extends HookConsumerWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addPageController);
    final selectedMoney = ref.watch(selectedMoneyStateProvider);
    final selectedSum = selectedMoney.map((money) => money.value).sum();

    return ref.watch(authUserStreamProvider).when(
          error: (e, st) => Center(
            child: Text(e.toString()),
          ),
          loading: () => const Center(
            child: ColoredBox(
              color: Colors.white,
              child: SizedBox.expand(
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          data: (user) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Spacer(flex: 2),
                        if (user != null)
                          ref.watch(expensesStreamProvider(user.uid)).when(
                              data: (expenses) {
                                final sum = expenses
                                    .map((expense) => expense.money)
                                    .sum();
                                return Column(
                                  children: [
                                    const Text(
                                      '5月',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Text(
                                      '$sum 円',
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                  ],
                                );
                              },
                              error: (e, st) => Text(e.toString()),
                              loading: () => const Text("Loading")),
                        const Spacer(flex: 1),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: '$selectedSum 円',
                                style: const TextStyle(fontSize: 24),
                              ),
                              const TextSpan(
                                text: ' を追加する',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 4,
                          children: Money.values.reversed.map((money) {
                            final isSelected = selectedMoney.contains(money);
                            return FilterChip(
                              label: Text(money.toDisplayText()),
                              showCheckmark: false,
                              elevation: 2,
                              selected: isSelected,
                              selectedColor: Colors.amber,
                              disabledColor: Colors.white,
                              onSelected: (onSelected) {
                                if (onSelected) {
                                  controller.select(money);
                                } else {
                                  controller.unselect(money);
                                }
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => controller.add(sum: selectedSum),
                          child: const Text('追加'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }
}
