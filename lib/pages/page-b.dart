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
        title: "Otto",
        subtitle: _isSelect ? "这就是不玩原神的下场" : "你玩原神吗",
        callback: () async {
          BrnDialogManager.showSingleButtonDialog(
            context,
            label: '不玩',
            title: "你玩原神吗",
            message: '不玩原神的人，素质品味修养都很低',
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
