import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/activity-card.dart';

class UserInfoModel extends ChangeNotifier {
  /// fields
  String _userName = '获取中';
  int _age = 0;
  bool _isLoad = false;
  bool _isLogin = false;
  String _token = '';

  /// getters/setters
  String get userName => _userName;
  int get age => _age;
  bool get isLoad => _isLoad;
  bool get isLogin => _isLogin;
  String get getMyToken => _token;

  set changeToken(String token) {
    _token = token;
  }

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

  void updateLoginState() async {
    if (!_isLogin) {
      _isLogin = true;
      notifyListeners();
    }
  }

  void refresh() {
    getUserInfo();
    notifyListeners();
  }
}
