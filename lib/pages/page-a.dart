// ignore_for_file: sort_child_properties_last

import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import '../models/counts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageA extends StatefulWidget {
  const PageA({super.key});

  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  var _counts = 0;

  @override
  Widget build(BuildContext context) {
    _counts = Provider.of<CountModel>(context).count;
    return Consumer<CountModel>(
        builder: (context, CountModel, child) => Container(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                      child: Text("counts: ${CountModel.count}")),
                  ElevatedButton(
                    onPressed: () async {
                      BrnLoadingDialog.show(context, content: 'Loading');
                      await Future.delayed(Duration(seconds: 1), () {
                        print("Finish");
                        BrnLoadingDialog.dismiss(context);
                        CountModel.increment();
                      });
                    },
                    child: const Text('increment'),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
              ),
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(top: 50),
            ));
  }
}
