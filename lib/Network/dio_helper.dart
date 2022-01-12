import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{

 static  Dio dio;


  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }


  static Future <Response> getData({
  @required String url,
   Map<String , dynamic>  query,
})async
  {
    return await dio.get(url , queryParameters: query);
  }


  static Future<Response> postData({
    @required String url,
    @required Map<String , dynamic> data,
    String lang,
    String token
})async
  {
    dio.options.headers =
    {
      'lang' : lang,
      'Authorization' : token,
      'Content-Type':'application/json',
    };
    return await dio.post(
      url ,
      data:data,
    );
  }

 static Future<Response> putData({
   @required String url,
   @required Map<String , dynamic> data,
   String lang,
   String token
 })async
 {
   dio.options.headers =
   {
     'lang' : lang,
     'Authorization' : token,
     'Content-Type':'application/json',
   };
   return await dio.put(
     url ,
     data:data,
   );
 }
}