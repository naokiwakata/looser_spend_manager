import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/money.dart';
import '../../extension/iterable.dart';
import 'add_page_controller.dart';

@RoutePage()
class AddPage extends HookConsumerWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addPageController);
    final selectedMoney = ref.watch(selectedMoneyStateProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Spacer(flex: 2),
                const Column(
                  children: [
                    Text(
                      '5月',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      '20,000円',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                const Spacer(flex: 1),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: '${selectedMoney.map((e) => e.value).sum()} 円',
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
                  onPressed: () {},
                  child: const Text('追加'),
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
