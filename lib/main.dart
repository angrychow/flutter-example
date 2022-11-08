import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/page-a.dart';
import 'pages/page-b.dart';
import 'models/counts.dart';
import 'models/user-info.dart';

void main() {
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
        title: Text('Navigation Bar'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: 'Page A'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Page B'),
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
