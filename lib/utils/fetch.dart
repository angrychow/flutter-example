import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/user-info.dart';
import 'dart:async';
import 'dart:io';

import 'package:provider/provider.dart';

enum Method { get, post, patch }

const baseURL = "http://localhost:3000/api/";

Future fetchData({
  required String url,
  required Method method,
  Map<String, dynamic> map = const {},
  String? myToken,
}) async {
  try {
    print("start fetching");
    Options options = myToken != null
        ? Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer " + myToken})
        : Options();
    Response? resp;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    switch (method) {
      case Method.get:
        print('start get');
        print(baseURL + url);
        resp = await dio.get(baseURL + url,
            queryParameters: map, options: options);
        break;
      case Method.post:
        print("start post");
        // FormData formData = FormData.fromMap(map);
        resp = await dio.post(baseURL + url, data: map);
        break;
      case Method.patch:
        resp = await dio.patch(baseURL + url, data: map, options: options);
        break;
    }
    if (resp != null) {
      print(resp);
      // print(resp.data['lx_max_req_len']);
      return resp;
    } else {
      // throw Exception("err");
      print("err");
    }
  } catch (e) {
    print(e);
    return false;
    // throw e;
  }
}
