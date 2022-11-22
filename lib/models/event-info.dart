import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/activity-card.dart';

class EventModel extends ChangeNotifier {
  /// fields
  String _title = '';
  String _subtitle = '';
  bool _isSubscribed = false;

  /// getters/setters
  String get title => _title;
  String get subtitle => _subtitle;
  bool get subscribed => _isSubscribed;

  /// constructor
  EventModel(String title, String subtitle, bool isSubscribed) {
    _title = title;
    _subtitle = subtitle;
    _isSubscribed = isSubscribed;
  }

  /// actions
  void subscribe() {
    if (!subscribed) {
      _isSubscribed = true;
      notifyListeners();
    }
  }

  void unsubscribe() {
    if (subscribed) {
      _isSubscribed = false;
      notifyListeners();
    }
  }
}

class EventInfoModel extends ChangeNotifier {
  /// fields
  bool _isLoad = false;
  List<EventModel> _events = [];

  /// getters/setters
  bool get isLoad => _isLoad;
  List<EventModel> events() => _events;

  /// actions
  void getEventInfo() async {
    if (!_isLoad) {
      await Future.delayed(Duration(seconds: 3), () {
        _events.clear();
        _events.add(EventModel('预订服务 1', '描述 1', false));
        _events.add(EventModel('预订服务 2', '描述 2', false));
        _events.add(EventModel('预订服务 3', '描述 3', false));
        _events.add(EventModel('预订服务 4', '描述 4', true));
        _events.add(EventModel('预订服务 5', '描述 5', true));
        _isLoad = true;
        notifyListeners();
      });
    } else {
      return;
    }
  }

  void refresh() {
    getEventInfo();
    notifyListeners();
  }
}
