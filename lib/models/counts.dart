import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountModel with ChangeNotifier {
  /// fields
  int _count = 0;

  /// getters/setters
  int get count => _count;

  set setCount(int val) {
    _count = val;
    notifyListeners();
  }

  /// actions
  void increment() {
    _count++;
    notifyListeners();
  }
}
