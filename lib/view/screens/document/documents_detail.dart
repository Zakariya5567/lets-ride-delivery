import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/documents_controller.dart';

class DocumentDetail extends StatefulWidget {
  const DocumentDetail({Key key}) : super(key: key);

  @override
  State<DocumentDetail> createState() => _DocumentDetailState();
}

class _DocumentDetailState extends State<DocumentDetail> {
  DocumentsController documentsController = Get.put(DocumentsController());
  int status = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            "Documents Detail",
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(0, 0, 0, 1),
            )),
            textAlign: TextAlign.center,
          )),
      body:SingleChildScrollView(
        
        child: GetBuilder(
            init: DocumentsController(),
            builder: (controller) {
              return documentsController.detailLoading == true
                  ? const Padding(
                      padding: EdgeInsets.only(top: 200.0),
                      child: Center(
                           child:  CircularProgressIndicator(
                                  color: Colors.black,
                                )
                            ))
                        : 
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Text(
                              documentsController.docName,
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),
                              textAlign: TextAlign.center,
                            ),
                          ),
      
                          Container(
                            height: MediaQuery.of(context).size.height/3,
                            width: double.infinity,
                            decoration:BoxDecoration(
                              border: Border.all(color: Colors.black54,width: 1),
                              color: Colors.grey.shade300,
                              image: DecorationImage(
                                
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  documentsController.frontImage
                                ),
                              )
                            ),
                             child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text("Front",
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),)
                              ),
                          ),
      
                          SizedBox(height: 10,),
      
                           Container(
                            height: MediaQuery.of(context).size.height/3,
                            width: double.infinity,
                            decoration:BoxDecoration(
                              border: Border.all(color: Colors.black54,width: 1),
                              color: Colors.grey.shade300,
                              image: DecorationImage(
                                
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  documentsController.backImage
                                ),
                              )
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text("back",
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),)
                              ),
                          ),
                            Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Issue Date: ${getFormattedDate(documentsController.issueDate)}",
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),
                              textAlign: TextAlign.center,
                            ),
                          ),
      
                           Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: Text(
                              "Expiry Date: ${getFormattedDate(documentsController.expiryDate)}",
                              style: GoogleFonts.ubuntu(
                                  textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),
                              textAlign: TextAlign.center,
                            ),
                          ),
      
                        ],
                      ));
            }),
      ),
  );
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
