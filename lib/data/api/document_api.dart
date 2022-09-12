import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_constants.dart';
import '../model/response/all_document_model.dart';
import '../model/response/delete_documents.dart';
import '../model/response/document_create_model.dart';


class DocumentApi{
  CreateDocumentModel createDocumentModel;
  AllDocumentModel allDocumentModel;
  DeleteDocumentModel deleteDocumentModel;
 

  create(){
    print("object");
  }
  

   Future<CreateDocumentModel> createDocumnetApi(
      String userId,
      String documentNo,
      String documentName,
      String expiryDate,
      String companyId,
      String issueDate,
      String docTypeId,
      File frontImg,
      File backImg,
      ) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       final accessToken = sharedPreferences.getString(AppConstants.TOKEN);
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    print("barear token is :$accessToken");

    String documentCreateUrl = AppConstants.documentCreateUrl;

    print(documentCreateUrl);
    print("calling");

    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(documentCreateUrl),

      
    );
    request.headers.addAll(headers);

     print("request.headers is ${request.headers}");

    //add text fields
    request.fields["delivery_man_id"] = userId;
    request.fields["document_no"] = documentNo;
    request.fields["document_name"] = documentName;
    request.fields["expiry_date"] = expiryDate.toString();
    request.fields["restaurant_id"] = companyId;
    request.fields["issue_date"] = issueDate.toString();
    request.fields["doc_type_id"] = docTypeId;

    //create multipart using filepath, string or bytes
    var frontPic =
        await http.MultipartFile.fromPath("image_url_front", frontImg.path);
   var backPic =
     await http.MultipartFile.fromPath("image_url_back", backImg.path);


     

    //add multipart to request
    request.files.add(frontPic);
    request.files.add(backPic);

    var response = await request.send();
  


    //Get the response from the server

    var responseData = await response.stream.toBytes();
    
    var responseString = String.fromCharCodes(responseData);

    print("responseString is: $responseString end response");

    var decodeResponse = jsonDecode(responseString);

    print("Decode response is $decodeResponse");

    createDocumentModel = CreateDocumentModel.fromJson(decodeResponse);

    return createDocumentModel;
  }
  
   Future<AllDocumentModel> getAllDocumentApi(
      Map<String, dynamic> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     final accessToken = sharedPreferences.getString(AppConstants.TOKEN);

    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    print("token is : $accessToken");

     print("sending data is : $data");

    String allDocumentUrl = AppConstants.allDocumentUrl;

    print(allDocumentUrl);
  

    var response = await http.post(Uri.parse(allDocumentUrl),
        body: data, headers: headers);
        

        print(response.body);
    final responseBody = response.body;
    final decodeResponse = jsonDecode(responseBody);
    allDocumentModel =
        AllDocumentModel.fromJson(decodeResponse);
    print(decodeResponse);

    return allDocumentModel;
  }

   
   Future<DeleteDocumentModel> deleteDocumentApi(
      Map<String, dynamic> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     final accessToken = sharedPreferences.getString(AppConstants.TOKEN);

    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    print("token is : $accessToken");

     print("sending data is : $data");

    String deleteDocumentUrl = AppConstants.deleteDocumentUrl;

    print(deleteDocumentUrl);
  

    var response = await http.post(Uri.parse(deleteDocumentUrl),
        body: data, headers: headers);
        

        print(response.body);
    final responseBody = response.body;
    final decodeResponse = jsonDecode(responseBody);
    deleteDocumentModel =
        DeleteDocumentModel.fromJson(decodeResponse);
    print(decodeResponse);

    return deleteDocumentModel;
  }

}