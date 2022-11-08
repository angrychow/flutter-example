import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoModel extends ChangeNotifier {
  String _userName = '获取中';
  int _age = 0;
  bool _isLoad = false;

  String get userName => _userName;
  int get age => _age;
  bool get isLoad => _isLoad;

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
}
