import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';

enum Method { get, post }

const baseURL =
    "https://portal-portm.meituan.com/horn/v1/modules/lx-web-config/prod?_lxsdk_rnd=1847f5435a10";

Future fetchData({
  required String url,
  required Method method,
  Map<String, dynamic> map = const {},
}) async {
  try {
    print("start fetching");
    Response? resp;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    switch (method) {
      case Method.get:
        print('start get');
        print(baseURL + url);
        resp = await dio.get(
          baseURL + url,
          queryParameters: map,
        );
        break;
      case Method.post:
        print("start post");
        FormData formData = FormData.fromMap(map);
        resp = await dio.post(url, data: formData);
        break;
    }
    if (resp != null && resp.data != null && resp.statusCode == 200) {
      print(resp.data);
      print(resp.data['lx_max_req_len']);
      return resp.data;
    } else {
      throw Exception("err");
    }
  } catch (e) {
    print(e.toString());
    throw e;
  }
}
