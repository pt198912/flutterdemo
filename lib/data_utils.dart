import 'package:flutter/material.dart';
import 'net_utils.dart';
import 'model/user_info.dart';
import 'api/api.dart';
class DataUtils{
  //登入获取用户信息
  static Future<UserInfo> doLogin(Map<String,String> params) async{
    var response=await NetUtils.post(Api.DO_LOGIN,params);
    UserInfo userInfo=UserInfo.fromJson(response['data']);
    return userInfo;
  }
}