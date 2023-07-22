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
