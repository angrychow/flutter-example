import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/page-a.dart';
import 'pages/page-b.dart';
import 'models/counts.dart';
import 'models/user-info.dart';
import 'utils/fetch.dart';

void main() {
  try {
    var ret = fetchData(url: '', method: Method.get);
    print(ret.toString());
  } catch (e) {
    print(e.toString());
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CountModel()),
      ChangeNotifierProvider(create: (context) => UserInfoModel()),
    ],
    child: const MaterialApp(
      home: MyApp(),
      title: 'Provider',
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;

  List<Widget> _pageList = [PageA(), PageB()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('社区养老APP'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: '我的'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '预约'),
        ],
        onTap: (value) {
          print(value);
          setState(() {
            _index = value;
          });
        },
        currentIndex: _index,
      ),
      body: _handlePage(),
    );
  }

  Widget _handlePage() {
    return _pageList[_index];
  }
}
