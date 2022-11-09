import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/activity-card.dart';

class UserInfoModel extends ChangeNotifier {
  String _userName = '获取中';
  int _age = 0;
  bool _isLoad = false;
  List<Widget> _serviceReserve = [];

  String get userName => _userName;
  int get age => _age;
  bool get isLoad => _isLoad;
  List<Widget> get serviceReserve => _serviceReserve;

  void getUserInfo() async {
    if (!_isLoad) {
      await Future.delayed(Duration(seconds: 3), () {
        _userName = '蒲俊宋';
        _age = 19;
        _isLoad = true;
        _serviceReserve = <Widget>[
          ActivityCard(
            key: Key('预定服务1'),
            title: '预定服务1',
            subtitle: 'description',
            callback: () {
              print("test");
            },
            iconData: Icons.add_alert_sharp,
          ),
          ActivityCard(
            key: Key('预定服务2'),
            title: '预定服务2',
            subtitle: 'description',
            callback: () {
              print("test");
            },
            iconData: Icons.tag_faces_outlined,
          ),
          ActivityCard(
            key: Key('预定服务3'),
            title: '预定服务3',
            subtitle: 'description',
            callback: () {
              print("test");
            },
            iconData: Icons.airline_seat_flat_angled_outlined,
          ),
        ];
        notifyListeners();
      });
    } else {
      return;
    }
  }
}
