import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../components/activity-card.dart';

class PageB extends StatefulWidget {
  const PageB({super.key});

  State<PageB> createState() => _PageAState();
}

class _PageAState extends State<PageB> {
  bool _isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ActivityCard(
        title: "可预约服务1",
        subtitle: _isSelect ? "已预约" : "未预约",
        callback: () async {
          BrnDialogManager.showSingleButtonDialog(
            context,
            label: '预约',
            title: "可预约服务1",
            message: '点击以确认预约',
            onTap: () {
              setState(() {
                _isSelect = true;
                Navigator.of(context).pop();
              });
            },
          );
        },
      ),
    );
  }
}
