import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:looser_spend_manager/extension/date_time.dart';
import 'package:looser_spend_manager/extension/iterable.dart';

import '../add/add_page_controller.dart';

@RoutePage()
class ListPage extends HookConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDateTime = ref.watch(selectedDateTimeProvider);

    return Scaffold(
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
                      return Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${selectedDateTime.formatMonth()}月",
                              style: const TextStyle(fontSize: 30),
                            ),
                            Text(
                              '$sumOfMonth 円',
                              style: const TextStyle(fontSize: 30),
                            ),
                            Expanded(
                              child: ListView(
                                children: expenses
                                    .map(
                                      (expense) => Column(
                                        children: [
                                          Text(
                                              "${expense.createdAt.dateTime!.formatDateTime()} ${expense.money}円")
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    error: (e, st) => Text(e.toString()),
                    loading: () => const Text("Loading")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
