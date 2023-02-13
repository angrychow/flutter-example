import 'package:bruno/bruno.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/activity-card.dart';
import 'package:flutter_application_1/models/event-info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/fetch.dart';
import 'package:provider/provider.dart';
import '../models/user-info.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  @override
  Widget build(BuildContext context) {
    // var _counts = Provider.of<CountModel>(context).count;
    // var _isUserInfoLoad = Provider.of<UserInfoModel>(context).isLoad;
    // var _isEventInfoLoad = Provider.of<EventInfoModel>(context).isLoad;
    var _isUserLogin = Provider.of<UserInfoModel>(context).isLogin;
    var _teleNum = new TextEditingController();
    var _pwd = new TextEditingController();
    return Center(
        child: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                  ],
                  decoration: const InputDecoration(
                      labelText: "Tel",
                      hintText: "请输入手机号",
                      prefixIcon: Icon(Icons.phone)),
                  keyboardType: TextInputType.number,
                  controller: _teleNum,
                ),
                SizedBox(height: 10),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z.]")),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "请输入密码",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  controller: _pwd,
                ),
                SizedBox(height: 10),
                MaterialButton(
                  child: Text("Submit"),
                  onPressed: () {
                    // Provider.of<UserInfoModel>(context, listen: false)
                    //     .updateLoginState();
                    fetchData(url: 'users/login', method: Method.post, map: {
                      "phone": _teleNum.text,
                      "password": _pwd.text
                    }).then((resp) {
                      print(resp);
                      if (resp != false) {
                        Provider.of<UserInfoModel>(context, listen: false)
                            .changeToken = resp.data['access_token'];
                        Provider.of<UserInfoModel>(context, listen: false)
                            .updateLoginState();
                      } else {
                        BrnDialogManager.showSingleButtonDialog(
                          context,
                          label: '登陆失败，请重新登陆',
                          title: '登陆失败',
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            )));
  }
}
