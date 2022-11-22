import 'package:bruno/bruno.dart';
import 'package:flutter_application_1/components/activity-card.dart';
import 'package:flutter_application_1/models/event-info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user-info.dart';

class PageA extends StatefulWidget {
  const PageA({super.key});

  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
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

    Function refreshUserInfoModel = Provider.of<UserInfoModel>(context).refresh;

    List<Widget> subscribedServices = [];
    Provider.of<EventInfoModel>(context).events().forEach((e) {
      if (e.subscribed) {
        subscribedServices.add(ActivityCard(
          key: Key(e.title),
          title: e.title,
          subtitle: e.subtitle,
          callback: () async {
            BrnDialogManager.showSingleButtonDialog(
              context,
              label: '取消预约',
              title: '取消预约' + e.title,
              message: '点击以取消预约',
              onTap: () {
                setState(() {
                  e.unsubscribe();
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
      return Consumer<UserInfoModel>(
        builder: (context, userInfoModel, child) => CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      ActivityCard(
                        title: userInfoModel.userName,
                        subtitle: "年龄 " + userInfoModel.age.toString(),
                        callback: () {
                          refreshUserInfoModel();
                        },
                        iconData: Icons.account_circle_outlined,
                      ),
                      BrnDashedLine(
                        contentWidget: Container(
                          height: 50,
                          // color: Colors.red,
                          // margin: EdgeInsets.all(5),
                        ),
                        dashedThickness: 1,
                        color: Colors.grey,
                        axis: Axis.horizontal,
                        dashedOffset: 5,
                      ),
                      ...subscribedServices
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  );
                },
                childCount: 1,
              ),
            ),
          ],
          // ignore: prefer_const_constructors
          // padding: EdgeInsets.only(top: 50),
        ),
      );
    } else {
      return Center(child: Text('Loading...'));
    }
  }
}
