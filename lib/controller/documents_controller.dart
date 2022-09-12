import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api/document_api.dart';
import '../data/model/response/all_document_model.dart';
import '../data/model/response/delete_documents.dart';
import '../data/model/response/document_create_model.dart';
import '../data/model/response/profile_model.dart';

class DocumentsController extends GetxController{

CreateDocumentModel createDocumentModel;
AllDocumentModel allDocumentModel;
ProfileModel profileModel;
DeleteDocumentModel deleteDocumentModel;
DocumentApi documentApi=DocumentApi();

  DateTime selectedissueDate;
  DateTime selectedexpiryDate;

  String dropdownValue;
  int documentid;

  bool isLoading;
  bool detailLoading;

  String docName;
  String frontImage;
  String backImage;
  String expiryDate;
  String issueDate;

  setDocName(String name){
    docName=name;
    update();
  }
  setfrontImage(String front){
    frontImage=front;
    update();
  }
   setbackImage(String back){
    backImage=back;
    update();
  }
  setIssue(String issue){
    issueDate=issue;
    update();
  }
  setExpiry(String expiry){
    expiryDate=expiry;
    update();
  }

   setdetailLoading(bool value){
    detailLoading=value;
    update();
  }

  setLoading(bool value){
    isLoading=value;
    update();
  }

  setDropdownValue(String value){
    dropdownValue=value;
    print("dropdownValue is:$dropdownValue");
    update;
  }


   setDocId(int value){
     documentid=value+1;
     print("doc type id is : $documentid");
     update();
   
  }

  String selectdateStatus;
  setDateStatus(String status){
    selectdateStatus=status;
    update();
  }


  createDocument( String documentNo, File frontImg, File backImg) async {

   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    int userId= sharedPreferences.getInt("user_id");


    print("user_id is : $userId");
    print("restaurant id is : 0");
    print("document No is :$documentNo");
    print("doc name is :$dropdownValue");
    print("expiry Date is :$selectedexpiryDate");
    print("issue Date is :$selectedissueDate");
    print("doc Type id is :$documentid");
    print("front Img id is :$frontImg");
    print("back Img id is :$backImg");

    await documentApi.create();
    
    var outputFormat = DateFormat('yyyy-MM-dd');
    var issue = outputFormat.format(selectedissueDate);

     var outputExpFormat = DateFormat('yyyy-MM-dd');
    var expiry = outputFormat.format(selectedexpiryDate);

    createDocumentModel = 
    await documentApi.createDocumnetApi(userId.toString(),
      documentNo, dropdownValue, issue, 
      0.toString(), expiry, documentid.toString(),
       frontImg, backImg);

      
  }


  getAllDocumnents() async {
    
   //setLoading(true);
    print("called get ALL DOC");
    
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     int userId= sharedPreferences.getInt("user_id");


    print("user_id is : $userId");
    print("restaurant_id is : 0");

   allDocumentModel=
    await   documentApi.getAllDocumentApi({"restaurant_id":0.toString(),"delivery_man_id":userId.toString()});
    //  documentApi.getAllDocumentApi({"restaurant_id":companyId.toString()});
    
   // setLoading(false);
    update();
  }


   deleteDocumnents(int docid) async {
    
   //setLoading(true);
    print("called delete document");
    
 
    print("document_id is : $docid");

   deleteDocumentModel=
    await   documentApi.deleteDocumentApi({"DocumentId":docid.toString()});
  
    update();
  }


}