import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
Map<String,dynamic> optHeader={
  'acccept-language':'zh-cn',
  'content-type':'application/json'
};
var dio=new Dio(BaseOptions(connectTimeout: 30000,headers: optHeader));
class NetUtils{
  static Future get(String url,[Map<String,dynamic> params]) async{
    var response;
    Directory documentsDir=await getApplicationDocumentsDirectory();
    String documentsPath=documentsDir.path;
    var dir=new Directory("$documentsPath/cookies");
    await dir.create();
    dio.interceptors.add(CookieManager(PersistCookieJar(dir:dir.path)));
    if(params!=null){
      response=await dio.get(url,queryParameters: params);
    }else{
      response=await dio.get(url);
    }
    return response.data;
  }
   static Future post(String url,Map<String,dynamic> params) async{
     var response=await dio.post(url,data: params);
     return response.data;
   }
}