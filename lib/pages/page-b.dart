import 'package:bruno/bruno.dart';
import 'package:flutter_application_1/components/activity-card.dart';
import 'package:flutter_application_1/models/event-info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user-info.dart';

class PageB extends StatefulWidget {
  const PageB({super.key});

  State<PageB> createState() => _PageBState();
}

class _PageBState extends State<PageB> {
  @override
  Widget build(BuildContext context) {
    // var _counts = Provider.of<CountModel>(context).count;
    var _isUserInfoLoad = Provider.of<UserInfoModel>(context).isLoad;
    var _isEventInfoLoad = Provider.of<EventInfoModel>(context).isLoad;

    if (!_isUserInfoLoad) {
      Provider.of<UserInfoModel>(context).getUserInfo();
    }
    if (!_isEventInfoLoad) {
      Provider.of<EventInfoModel>(context).getEventInfo();
    }

    List<Widget> unsubscribedServices = [];
    Provider.of<EventInfoModel>(context).events().forEach((e) {
      if (!e.subscribed) {
        unsubscribedServices.add(ActivityCard(
          key: Key(e.title),
          title: e.title,
          subtitle: e.subtitle,
          callback: () async {
            BrnDialogManager.showSingleButtonDialog(
              context,
              label: '预约',
              title: '预约' + e.title,
              message: '点击以确认预约',
              onTap: () {
                setState(() {
                  e.subscribe();
                  Navigator.of(context).pop();
                });
              },
            );
          },
        ));
      }
    });

    if (_isUserInfoLoad && _isEventInfoLoad) {
      BrnLoadingDialog.dismiss(context);
      return CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Column(
                  children: unsubscribedServices,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                );
              },
              childCount: 1,
            ),
          ),
        ],
      );
    } else {
      return Center(child: Text('Loading...'));
    }
  }
}
