import 'dart:convert';
import 'dart:io';
import 'package:efood_multivendor_driver/controller/chat_controller.dart';
import 'package:efood_multivendor_driver/data/model/response/get_chat_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constants.dart';
import '../model/response/all_document_model.dart';
import '../model/response/delete_documents.dart';
import '../model/response/document_create_model.dart';

class ChatApi {
  GetChatModel getChatModel;

  Future<GetChatModel> getChatApi(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString(AppConstants.TOKEN);
    int orderId=id;
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    print("token is : $accessToken");
    print("ORDERID--->>>>> $orderId");

    String getMessagesUrl = AppConstants.GetMessagesUrl;
    String url = "${getMessagesUrl}?OrderId=$orderId";
    //String url = "${getMessagesUrl}?OrderId=100025";
    print(url);

    try{
    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);
    final responseBody = response.body;
    final decodeResponse = jsonDecode(responseBody);
    getChatModel = GetChatModel.fromJson(decodeResponse);
    print(decodeResponse);

    return getChatModel;
    }catch (error){

     print("error is ======> $error");
     ChatController chatController=Get.put(ChatController());
     chatController.setLoading(false);

    }

  }

  Future<GetChatModel> getSupportMessageApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString(AppConstants.TOKEN);
    final userId = sharedPreferences.getInt("user_id");
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    print("token is : $accessToken");
    print("USERID--->>>>> $userId");

    String getMessagesUrl = AppConstants.getSupportMessagesUrl;
    String url = "${getMessagesUrl}$userId";
    print("Get support message url ====>>> $url");

    try{
      var response = await http.get(Uri.parse(url), headers: headers);

      print("response body is ====>>> ${response.body}");
      final responseBody = response.body;
      final decodeResponse = jsonDecode(responseBody);
      getChatModel = GetChatModel.fromJson(decodeResponse);
      print("decode response is ====>>> $decodeResponse");


      return getChatModel;
    }catch (error){

      print("error is ======> $error");
      ChatController chatController=Get.put(ChatController());
      chatController.setLoading(false);

    }

  }

  sendChatApi(Map<String,dynamic> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString(AppConstants.TOKEN);
    final userId = sharedPreferences.getInt("user_id");

    print("Sending data is $data");
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    print("token is : $accessToken");

    String sendMessageurl = AppConstants.sendMessageurl;
    
    print(sendMessageurl);

    var response = await http.post(Uri.parse(sendMessageurl), body:data, headers: headers);

    print(response.body);
    final responseBody = response.body;
    print(responseBody);

  }

  sendSupportMessageApi(Map<String,dynamic> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString(AppConstants.TOKEN);
    final userId = sharedPreferences.getInt("user_id");

    print("Sending data is $data");
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    print("token is : $accessToken");

    String sendMessageurl = AppConstants.sendSupportMessagesUrl;

    print(sendMessageurl);

    var response = await http.post(Uri.parse(sendMessageurl), body:data, headers: headers);

    print(response.body);
    final responseBody = response.body;
    print(responseBody);

  }


}
