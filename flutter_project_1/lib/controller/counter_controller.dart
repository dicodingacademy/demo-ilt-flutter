import 'package:flutter/widgets.dart';

class CounterController extends ChangeNotifier {
  int _counter = 1;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter == 0) return;
    _counter--;
    notifyListeners();
  }
}
