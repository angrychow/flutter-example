import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/page-a.dart';
import 'pages/page-b.dart';
import 'models/user-info.dart';
import 'models/event-info.dart';
import 'pages/login.dart';
import 'utils/fetch.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      // ChangeNotifierProvider(create: (context) => CountModel()),
      ChangeNotifierProvider(create: (context) => UserInfoModel()),
      ChangeNotifierProvider(create: (context) => EventInfoModel())
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
    bool _isLogin = Provider.of<UserInfoModel>(context).isLogin;
    // fetchData(url: 'services', method: Method.get).then((resp) {
    //   if (resp) {
    //     Provider.of<UserInfoModel>(context, listen: false).updateLoginState();
    //   }
    // });
    if (_isLogin) {
      return Scaffold(
        appBar: AppBar(
          title: Text('社区养老 APP'),
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
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('社区养老 APP'),
        ),
        body: PageLogin(),
      );
    }
  }

  Widget _handlePage() {
    return _pageList[_index];
  }
}
