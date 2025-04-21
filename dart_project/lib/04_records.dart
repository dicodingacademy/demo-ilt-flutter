void records() {
  int oneMillion = 1_000_000;
  bool isIndonesian = true;

  final (fruitName, totalFruit) = ('Apel', 5);
  print('$fruitName sebanyak $totalFruit buah.');
  // Apel sebanyak 5 buah.

  ({int a, bool b}) record;
  record = (a: oneMillion, b: isIndonesian);
  print(record.a); // 1000000
  print(record.b); // true
}
