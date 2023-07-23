import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extension/date_time.dart';
import '../../extension/iterable.dart';
import '../add/add_page_controller.dart';

@RoutePage()
class ListPage extends HookConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDateTime = ref.watch(selectedDateTimeProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '2023年7月',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
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
                              const SizedBox(height: 8),
                              Text(
                                '$sumOfMonth 円',
                                style: const TextStyle(fontSize: 30),
                              ),
                              const Divider(),
                              Expanded(
                                child: ListView(
                                  children: expenses
                                      .map(
                                        (expense) => Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 0, 0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    expense.createdAt.dateTime!
                                                        .formatDateTime(),
                                                  ),
                                                  const Spacer(),
                                                  Text(" ${expense.money}円"),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.delete_forever,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              const SizedBox(height: 8),
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
      ),
    );
  }
}
