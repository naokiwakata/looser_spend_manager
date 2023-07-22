import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: '1000円',
                        style: TextStyle(fontSize: 24),
                      ),
                      TextSpan(
                        text: ' を追加する',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 4,
                  children: Money.values.reversed
                      .map((money) => FilterChip(
                            label: Text(money.toDisplayText()),
                            onSelected: (isSelected) {},
                          ))
                      .toList(),
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

enum Money {
  jpy100(value: 100),
  jpy200(value: 200),
  jpy500(value: 500),
  jpy800(value: 800),
  jpy1000(value: 1000),
  jpy1500(value: 1500),
  jpy2000(value: 2000),
  jpy3000(value: 3000),
  jpy5000(value: 5000),
  jpy7000(value: 7000),
  jpy10000(value: 10000),
  jpy15000(value: 15000),
  jpy20000(value: 20000),
  jpy50000(value: 50000);

  const Money({required this.value});
  final int value;
}

extension MoneyExt on Money {
  String toDisplayText() {
    return '$value';
  }
}
