import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class PageB extends StatefulWidget {
  const PageB({super.key});

  State<PageB> createState() => _PageAState();
}

class _PageAState extends State<PageB> {
  var _counts = 1;

  @override
  Widget build(BuildContext context) {
    return Text("counts: ${_counts}");
  }
}
