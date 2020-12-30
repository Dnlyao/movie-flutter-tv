import 'package:dio/dio.dart';

String ip = "127.0.0.1:8080";

class BaseApiRequest {
  Future<Map> getRequest(
      {String interface, bool ifNeed, Map<String, dynamic> param}) async {
    try {
      Response response;
      Dio dio = new Dio();
      if (ifNeed) {
        //我们这里就只展示一个需要token参数了其余的可以自己加
        String token = ""; //token的来源，可以根据你们的需要去实现，例如可以从本地存储中取出，也可以从网络接口中获取
        dio.options.headers = {
          'token': token
        }; //这里的头信息不止一个token，到时候按照map的规范自行添加就好
      } else {
        dio.options.headers =
            {}; //里面的头信息需要自己添加，至少加一个content_type吧，其实加不加都一样，加了好看，不加看着难受
      }
      print("请求地址--> " + ip + interface);
      print("参数--> $param");
      response = await dio.get(ip + interface, queryParameters: param);

      if (response.statusCode == 200) {
        //成功
        print("TMD，终于成功了哦， response.data = ${response.data}");
        return response.data;
      } else {
        throw Exception("绝对是接口的问题！！！！！！");
      }
    } catch (e) {
//      return print(e);  //为什么不行呢 因为我们是map类型，日了狗了，早知道就不加泛型map了
      return {'异常异常！！！！出错误了哦': e.toString()};
    }
  }

  Future<Map> postRequest(
      {String interface, bool ifNeed, Map<String, dynamic> param}) async {
    try {
      Response response;
      Dio dio = new Dio();
      if (ifNeed) {
        //我们这里就只展示一个需要token参数了其余的可以自己加
        String token = ""; //token的来源，可以根据你们的需要去实现，例如可以从本地存储中取出，也可以从网络接口中获取
        dio.options.headers = {
          'token': token
        }; //这里的头信息不止一个token，到时候按照map的规范自行添加就好
      } else {
        dio.options.headers =
            {}; //里面的头信息需要自己添加，至少加一个content_type吧，其实加不加都一样，加了好看，不加看着难受
      }

      print("请求地址--> " + ip + interface);
      print("参数--> $param");
      response = await dio.post(ip + interface, queryParameters: param);

      if (response.statusCode == 200) {
        //成功
        print("TMD，终于成功了哦， response.data = ${response.data}");
        return response.data;
      } else {
        throw Exception("绝对是接口的问题！！！！！！");
      }
    } catch (e) {
//      return print(e);  //为什么不行呢 因为我们是map类型，日了狗了，早知道就不加泛型map了
      return {'异常异常！！！！出错误了哦': e.toString()};
    }
  }
}
