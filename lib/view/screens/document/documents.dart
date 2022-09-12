import 'dart:async';
import 'package:efood_multivendor_driver/view/screens/document/add_document.dart';
import 'package:efood_multivendor_driver/view/screens/document/documents_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controller/documents_controller.dart';
import '../../../theme/light_theme.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key key}) : super(key: key);

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  getDocumentList() async {
    documentsController.setLoading(true);

    await documentsController.getAllDocumnents();

    documentsController.setLoading(false);
  }

  @override
  void initState() {
    getDocumentList();
    super.initState();
  }

  DocumentsController documentsController = Get.put(DocumentsController());
  int status = 1;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder(
        init: DocumentsController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
                elevation: 2,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_outlined),
                  color: Colors.black,
                ),
                title: Text(
                  "Documents",
                  style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                   color: Color.fromRGBO(0, 0, 0, 1),
                  )),
                  textAlign: TextAlign.center,
                )),
            body: documentsController.isLoading == true
                ? const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )))
                : Container(
                    child: documentsController.allDocumentModel.data.isEmpty
                        ? Center(
                            child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "+ Add Document",
                                style: GoogleFonts.ubuntu(
                                    textStyle: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                )),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              Get.to(const AddDocuments(),
                                  duration: const Duration(milliseconds: 500),
                                  transition: Transition.leftToRight,
                                  curve: Curves.easeInOut);
                            },
                          ))
                        :

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                              itemCount:
                              //1,
                               documentsController
                                    .allDocumentModel.data.length,
                                itemBuilder: (context, index) {
                                  final doc = documentsController
                                      .allDocumentModel.data[index];

                          return Padding(
                            padding:  EdgeInsets.all(height*0.02),
                            child: Container(

                              height: height*0.65,
                               decoration:BoxDecoration(
                                       borderRadius: BorderRadius.circular(15),
                                       color: light.cardColor,
                                    ),
                              

                              child: 
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: height*0.25,
                                      decoration:BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        image: DecorationImage(
                                         fit: BoxFit.fill,
                                    image: NetworkImage(
                                      doc.imageUrlFront
                                    ) 
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      )
                                    ),
                                    SizedBox(height: height*0.02,),

                                     Text(
                                                    doc.documentName,
                                                    style: GoogleFonts.ubuntu(
                                                        textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      // color: Color.fromRGBO(
                                                      //     0, 0, 0, 1),
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  ),

                                     SizedBox(height: height*0.02,),
                                     Row(
                                            //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                
                                                   Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                  
                                                     Text(
                                                    "Issue date:",
                                                    style: GoogleFonts.ubuntu(
                                                        textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      // color: Colors.black54,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                    SizedBox(height: height*0.02,),
                                                  Text(
                                                    '${getFormattedDate(doc.issueDate.toString())}',
                                                    style: GoogleFonts.ubuntu(
                                                        textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      //  color: Colors.black54,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  ),

                                                  

                                                  ],),
                                                 
                                          SizedBox(width: width/3,),
                                                  Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                 
                                                    children: [

                                                                                          Text(
                                                    "Expiry:",
                                                    style: GoogleFonts.ubuntu(
                                                        textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      // color: Colors.black54,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                   SizedBox(height: height*0.02,),
                                                  Text(
                                                    '${getFormattedDate(doc.expiryDate.toString())}',
                                                    style: GoogleFonts.ubuntu(
                                                        textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      //  color: Colors.black54,
                                                    )),
                                                    textAlign: TextAlign.center,
                                                  )
                                                   
                                              

                                                  ],)
                                                 
                                                ],
                                              ),

                                      SizedBox(height: height*0.02,),
                                         Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                          InkWell(
                                            onTap: ()async{
                                              documentsController.setLoading(true);

                                              await  documentsController.deleteDocumnents(doc.id);

                                              initState();

                                              documentsController.setLoading(false);

                                            },
                                            child: Container(
                                              height: height*0.07,
                                               width: width*0.3,
                                              decoration: BoxDecoration(
                                                      color: light.colorScheme.secondary,
                                                borderRadius: BorderRadius.circular(15),
                                                
                                              ),
                                              child:  Center(
                                                child: Text(
                                                        "Remove",
                                                        style: GoogleFonts.ubuntu(
                                                            textStyle: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w400,
                                                           color: Colors.white,
                                                        )),
                                                        textAlign: TextAlign.center,
                                                      ),
                                              ),
                                                    
                                            ),
                                          ),

                                          SizedBox(width: 8,),

                                          
                                          InkWell(
                                               onTap: () {
                                            documentsController.setdetailLoading(true);

                                            documentsController
                                                .setDocName(doc.documentName);
                                            documentsController
                                                .setfrontImage(doc.imageUrlFront);
                                            documentsController
                                                .setbackImage(doc.imageUrlBack);
                                            documentsController.setIssue(
                                                doc.issueDate.toString());
                                            documentsController.setExpiry(
                                                doc.expiryDate.toString());
                                             
                                            Get.to(() => DocumentDetail(),
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                transition:
                                                    Transition.leftToRight,
                                                curve: Curves.easeInOut);

                                                Timer(Duration(seconds: 1), (){
                                                  documentsController.setdetailLoading(false);
                                                });

                                            
                                          },
                                            child: Container(
                                             height: height*0.07,
                                               width: width*0.3,
                                              decoration: BoxDecoration(
                                                color: light.colorScheme.secondary,
                                                borderRadius: BorderRadius.circular(15),
                                                
                                              ),
                                              child:  Center(
                                                child: Text(
                                                        "Detail",
                                                        style: GoogleFonts.ubuntu(
                                                            textStyle: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.white,
                                                        )),
                                                        textAlign: TextAlign.center,
                                                      ),
                                              ),
                                                    
                                            ),
                                          ),


                                          SizedBox(height: height*0.09,)

                                                  
                                                  ],),



                                                  Container(
                                            height: height*0.08,
                                            width: width,
                                            decoration: BoxDecoration(
                                                    color:
                                                    
                                                    
                                                    doc.documentStatusName=="Pending"?Colors.purple  
                                                    :doc.documentStatusName=="Rejected"?Colors.red:Colors.green,
                                              borderRadius: BorderRadius.circular(15),
                                              
                                            ),
                                            child:  Center(
                                              child: Text(
                                                       "${doc.documentStatusName}",
                                                      style: GoogleFonts.ubuntu(
                                                          textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                         color: Colors.white,
                                                      )),
                                                      textAlign: TextAlign.center,
                                                    ),
                                            ),
                                                  
                                          ),

                                              
                                  
                                  ],
                                ),
                              ),

                            ),
                          );
                          
                        })
                       
                          ),
               
            floatingActionButton: documentsController.isLoading == true
                ? null
                : documentsController.allDocumentModel.data.isEmpty
                    ? null
                    : FloatingActionButton(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.to(const AddDocuments(),
                              duration: const Duration(milliseconds: 500),
                              transition: Transition.leftToRight,
                              curve: Curves.easeInOut);
                        },
                      ),
          );
        });
  }

  String getFormattedDate(String date) {
    // Convert into local date format.
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }
}
