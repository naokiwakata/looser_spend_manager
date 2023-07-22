extension IterableExt on Iterable {
  int sum() {
    int sum = 0;
    forEach((element) {
      sum += element as int;
    });

    return sum;
  }
}
