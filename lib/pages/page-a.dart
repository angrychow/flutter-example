// ignore_for_file: sort_child_properties_last

import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/components/activity-card.dart';
import '../models/counts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user-info.dart';

class PageA extends StatefulWidget {
  const PageA({super.key});

  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  var _counts = 0;
  var _isLoad = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   BrnLoadingDialog.show(
    //     context,
    //     content: "Loading",
    //     barrierDismissible: false,
    //   );
    // }); //这个钩子只会被调用一次，第一次渲染完毕的时候调用这个
  }

  @override
  Widget build(BuildContext context) {
    _counts = Provider.of<CountModel>(context).count;
    _isLoad = Provider.of<UserInfoModel>(context).isLoad;
    Provider.of<UserInfoModel>(context).getUserInfo();
    if (_isLoad) {
      BrnLoadingDialog.dismiss(context);
      return Consumer<UserInfoModel>(
        builder: (context, UserInfoModel, child) => CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      ActivityCard(
                        title: UserInfoModel.userName,
                        subtitle: "年龄 " + UserInfoModel.age.toString(),
                        callback: () {
                          print("test");
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
                      ...UserInfoModel.serviceReserve,
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
      return Text("");
    }
  }
}
