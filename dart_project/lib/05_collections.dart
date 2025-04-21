void list() {
  List<String> fruits = ["Apel", "Semangka"];
  print(fruits.length); // 2
  print(fruits + (["Mangga"])); // [Apel, Semangka, Mangga]
  print(fruits[1]); // Semangka
}

void set() {
  Set<num> numbers = {1, 2, 5, 7};
  numbers.add(4); // add item
  print(numbers.length); // 5
  numbers.add(2); // add item
  print(numbers.length); // ?
}

void map() {
  Map<String, num> productPrices = {'Apel': 3.5, 'Pisang': 2};
  print(productPrices["Apel"]); // 3.5
}
