void forLoop() {
  for (int i = 1; i <= 5; i++) {
    print(i);
  }
}

void forInLoop() {
  final items = [1, 2, 3, 4, 5];
  for (int i in items) {
    print(i);
  }
}

void forEachLoop() {
  final items = [1, 2, 3, 4, 5];
  items.forEach(print);
}
