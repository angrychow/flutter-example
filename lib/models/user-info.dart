import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/activity-card.dart';

class UserInfoModel extends ChangeNotifier {
  /// fields
  String _userName = '获取中';
  int _age = 0;
  bool _isLoad = false;

  /// getters/setters
  String get userName => _userName;
  int get age => _age;
  bool get isLoad => _isLoad;

  /// actions
  void getUserInfo() async {
    if (!_isLoad) {
      await Future.delayed(Duration(seconds: 3), () {
        _userName = '蒲俊宋';
        _age = 19;
        _isLoad = true;
        notifyListeners();
      });
    } else {
      return;
    }
  }

  void refresh() {
    getUserInfo();
    notifyListeners();
  }
}
