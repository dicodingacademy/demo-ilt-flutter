import 'package:dart_project/12_car.dart';

void main() {
  Car myCar = Car("Merah", 2, "A 1234 BC");

  Car dicoCar = Car("Abu", 5, "D 5678 EF");
  dicoCar.forward(); // Mobil berjalan
  print(dicoCar.capacity); // 5
}
