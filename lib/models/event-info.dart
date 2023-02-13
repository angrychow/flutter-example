import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/fetch.dart';
import 'package:provider/provider.dart';
import '../components/activity-card.dart';

class EventModel extends ChangeNotifier {
  /// fields
  String _title = '';
  String _subtitle = '';
  bool _isSubscribed = false;
  int _id = 0;

  /// getters/setters
  String get title => _title;
  String get subtitle => _subtitle;
  bool get subscribed => _isSubscribed;
  int get id => _id;

  set setSubscribed(bool val) {
    _isSubscribed = val;
  }

  /// constructor
  EventModel(String title, String subtitle, bool isSubscribed, int id) {
    _title = title;
    _subtitle = subtitle;
    _isSubscribed = isSubscribed;
    _id = id;
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
  void getEventInfo(String myToken) async {
    if (!_isLoad) {
      // await Future.delayed(Duration(seconds: 3), () {
      //   _events.clear();
      //   _events.add(EventModel('预订服务 1', '描述 1', false));
      //   _events.add(EventModel('预订服务 2', '描述 2', false));
      //   _events.add(EventModel('预订服务 3', '描述 3', false));
      //   _events.add(EventModel('预订服务 4', '描述 4', true));
      //   _events.add(EventModel('预订服务 5', '描述 5', true));
      //   _isLoad = true;
      //   notifyListeners();
      // });
      await fetchData(url: 'services', method: Method.get, myToken: myToken)
          .then((resp) => {
                resp.data.forEach((e) {
                  _events.add(
                      EventModel(e['name'], e['description'], false, e['id']));
                  print(e);
                  _isLoad = true;
                  // notifyListeners();
                })
              });
      await fetchData(
              url: 'services?subscribed=true',
              method: Method.get,
              myToken: myToken)
          .then((resp) => {
                resp.data.forEach((eventSubscribed) {
                  _events.forEach((element) {
                    if (element.title == eventSubscribed['name']) {
                      element.setSubscribed = true;
                    }
                  });
                })
              });
    } else {
      return;
    }
  }

  void refresh(String myToken) {
    getEventInfo(myToken);
    notifyListeners();
  }

  void changeSubState(String myToken, int id, bool isSub) async {
    await fetchData(
        url: 'services/' + id.toString(),
        method: Method.patch,
        myToken: myToken,
        map: isSub ? {"subscribed": true} : {});
  }
}
