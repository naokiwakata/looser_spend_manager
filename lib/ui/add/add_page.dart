import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/money.dart';
import '../../extension/date_time.dart';
import '../../extension/iterable.dart';
import '../../main.dart';
import '../../util/result.dart';
import 'add_page_controller.dart';

@RoutePage()
class AddPage extends HookConsumerWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addPageController);
    final selectedMoney = ref.watch(selectedMoneyStateProvider);
    final selectedSum = selectedMoney.map((money) => money.value).sum();
    final selectedDateTime = ref.watch(selectedDateTimeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '2023年7月',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ref.watch(expensesByMonthStreamProvider).when(
                    data: (expenses) {
                      final sumOfMonth =
                          expenses.map((expense) => expense.money).sum();
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 122, 121, 121),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Text(
                              selectedDateTime.formatMonth(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '¥ $sumOfMonth',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                        text: '$selectedSum',
                        style: const TextStyle(fontSize: 30),
                      ),
                      const TextSpan(
                        text: ' 円を追加する',
                        style: TextStyle(fontSize: 14),
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
                      label: Text(
                        money.toDisplayText(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      showCheckmark: false,
                      elevation: 2,
                      selected: isSelected,
                      selectedColor:
                          Theme.of(context).colorScheme.primaryContainer,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.clear(),
                      child: const Text('クリア'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: selectedSum == 0
                            ? MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.surfaceVariant,
                              )
                            : MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.surface),
                      ),
                      onPressed: () async {
                        if (selectedSum == 0) {
                          return;
                        }
                        final messengerState =
                            ref.read(scaffoldMessengerKeyProvider).currentState;

                        final result = await controller.add(sum: selectedSum);
                        switch (result) {
                          case Success():
                            messengerState?.showSnackBar(
                                const SnackBar(content: Text("追加しました")));
                            break;
                          case Failure():
                            messengerState?.showSnackBar(
                                const SnackBar(content: Text("失敗しました")));
                            break;
                        }
                      },
                      child: const Text('追加'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
