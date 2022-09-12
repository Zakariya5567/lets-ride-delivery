import 'dart:io';

import 'package:efood_multivendor_driver/view/screens/document/documents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../controller/documents_controller.dart';
import '../../base/custom_button.dart';


class AddDocuments extends StatefulWidget {
  const AddDocuments({Key key}) : super(key: key);

  @override
  State<AddDocuments> createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  DocumentsController documentsController = Get.put(DocumentsController());

  String _dropDownValue;

  File frontImage;
  File backImage;
  final picker = ImagePicker();

  TextEditingController documentNumberController = TextEditingController();
  TextEditingController issueDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();

  var documnetType = <String>[
 "Acra","Agreement Licensee",
  "Rental Agreement","Halal Muis Certified",
"Food Hygiene Cert","Local Food Stall Based ",
   "SFA / NEA license ","Other certificates",
];

  void showPickerFront(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          didChangeDependencies();
          return SafeArea(
              child: Wrap(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close")),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: () {
                  frontimageFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
                onTap: () {
                  frontImageFromCamera();
                  Navigator.pop(context);
                },
              ),
            ],
          ));
        });
  }


  void showPickerBack(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          didChangeDependencies();
          return SafeArea(
              child: Wrap(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close")),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: () {
                  backimageFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
                onTap: () {
                  backImageFromCamera();
                  Navigator.pop(context);
                },
              ),
            ],
          ));
        });
  }



 Future frontImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        frontImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
 Future  frontimageFromGallery() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
 setState(() {
      if (pickedFile != null) {
        frontImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


// back image
Future backImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        backImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
Future  backimageFromGallery() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
 setState(() {
      if (pickedFile != null) {
        backImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
     final width=MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
            color: Colors.black,
          ),

          title: Text(
            "Add Document",
            style: GoogleFonts.ubuntu(
                textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(0, 0, 0, 1),
            )),
            textAlign: TextAlign.center,
          ),
          // flexibleSpace:
          // Container(

          //   height: 300,
          //   decoration: BoxDecoration(
          //     color: Colors.black,
          //     borderRadius: BorderRadius.only(
          //       bottomRight: Radius.circular(100)
          //     )
          //   ),
          // ),
        ),
        body: GetBuilder(
            init: DocumentsController(),
            builder: (controller) {
              return 
              documentsController.isLoading==true?
               Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 200),
              child:
                Center(
                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                )
                            )
                        : 
              Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black26, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Document Type",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                  )),
                                  //textAlign: TextAlign.center,
                                ),
                                DropdownButton(
                                  hint: _dropDownValue == null
                                      ? const Text(
                                          'Select type',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        )
                                      : Text(
                                          _dropDownValue,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                  isExpanded: true,
                                  underline: Container(
                                      height: 2.0,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black87,
                                                  width: 0.0)))),
                                  iconSize: 30.0,
                                  style: const TextStyle(color: Colors.black),
                                  items: documnetType.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        documentsController.setDropdownValue(val);
                                        _dropDownValue = val;
                                        
                                        documentsController.setDocId(
                                          documnetType.indexOf(val)

                                        );

                                      },
                                    );
                                  },
                                ),

                                //---------------------------------------------
                                //document number
                                Text(
                                  "Document No",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                  )),
                                  // textAlign: TextAlign.center,
                                ),

                                TextField(
                                  controller: documentNumberController,
                                  keyboardType: TextInputType.number,
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                //-----------------------------

                                //Date calander
                                Row(
                                  //issue date
                                  children: [
                                    Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: TextField(
                                         focusNode: FocusNode(),
                                          keyboardType: TextInputType.none,
                                          decoration: const InputDecoration(
                                            hintText: "Issue Date",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                            suffixIcon: Icon(
                                              Icons.calendar_month_rounded,
                                              color: Colors.black,
                                            ),
                                        
                                          ),
                                          controller: issueDateController,
                                          onTap: () {
                                            documentsController
                                                .setDateStatus("issue");
                                            _selectDate(context);
                                          },
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    //expiry date
                                    Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: TextField(
                                              keyboardType: TextInputType.none,
                                              focusNode: FocusNode(),
                                          decoration: const InputDecoration(
                                            hintText: "Expiry Date",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                            suffixIcon: Icon(
                                              Icons.calendar_month_rounded,
                                              color: Colors.black,
                                            ),
                                          ),
                                          controller: expiryDateController,
                                          onTap: () {
                                            documentsController
                                                .setDateStatus("expiry");
                                            _selectDate(
                                              context,
                                            );
                                          },
                                        ))
                                  ],
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                //----------------------------------------
                                //upload doc
                                Text(
                                  "Upload your doc file here",
                                  style: GoogleFonts.ubuntu(
                                      textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  )),
                                  //textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    //front
                                    InkWell(
                                      onTap: (() {
                                        
                                      showPickerFront(context);
                                      }),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            //color: Colors.red,
                                            image: 
                                            frontImage != null ? 
                                            DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(frontImage)
                                               
                                            ):null,
                                    
                                            border: Border.all(
                                                color: Colors.black12, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // height: 190,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4.5,
                                        width: MediaQuery.of(context).size.width /
                                            2.5,
                                        child: 
                                        frontImage != null ? Text(""):
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.upload_file_outlined,
                                              color: Colors.black54,
                                              size: 50,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Front ",
                                              style: GoogleFonts.ubuntu(
                                                  textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(0, 0, 0, 1),
                                              )),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          30,
                                    ),
                                    //back
                                    InkWell(
                                      onTap: (() {
                                        showPickerBack(context);
                                      }),

                                      child: Container(
                                        decoration: BoxDecoration(
                                            //color: Colors.red,
                                              image: backImage != null ?  DecorationImage(
                                                fit: BoxFit.cover,
                                                image:FileImage(backImage)
                                              ):null,
                                    
                                            border: Border.all(
                                                color: Colors.black12, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // height: 190,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4.5,
                                        width: MediaQuery.of(context).size.width /
                                            2.5,
                                    
                                        child: 
                                        backImage != null ? Text(""):
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                             const Icon(
                                              Icons.upload_file_outlined,
                                              color: Colors.black54,
                                              size: 50,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "back ",
                                              style: GoogleFonts.ubuntu(
                                                  textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(0, 0, 0, 1),
                                              )),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Add button
                        CustomButton(
                      buttonText: 'Add Documnet'.tr,
                      onPressed: ()async {
                         
                         

                         if(_dropDownValue==null){
                             ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(
                                       content: const Text('Add document type first')));
                         }
                            else if(documentNumberController.text.isEmpty){
                             ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(
                                       content: const Text('Add document number first')));
                         }
                          else if( issueDateController.text.isEmpty){
                             ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(
                                       content: const Text('Add issue date first')));
                         }
                          else if( expiryDateController.text.isEmpty){
                             ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(
                                       content: const Text('Add expiry date first')));
                         }
                         else if( frontImage == null){
                             ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(
                                       content: const Text('Add fornt picture first')));
                         }
                        else if( backImage == null){
                             ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(
                                       content: const Text('Add back picture first')));
                         }
                         
                        
                        
                       else  if(documentNumberController.text.isNotEmpty
                         && issueDateController.text.isNotEmpty
                         && expiryDateController.text.isNotEmpty
                         && _dropDownValue.isNotEmpty
                         && frontImage != null
                         && backImage != null){

                          documentsController.setLoading(true);

                           await  documentsController.createDocument(
                            documentNumberController.text, 
                               frontImage,
                                backImage);
                        
                        
                                setState(() {
                                   documentNumberController.clear();
                          issueDateController.clear();
                          expiryDateController.clear();
                          _dropDownValue = null;
                          frontImage = null;
                          backImage = null;

                          
                                });
                              

                                Get.to(DocumentsPage(),
                                  );
                              
                                 await documentsController.getAllDocumnents();

                                documentsController.setLoading(false);
                        
                        
                        
                         }
                         else{
                           ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(
                                       content: const Text('Please fill all fields')));
                             
                             
                         }
                         
                             
                        
                         },
                    )
                         
                         
                         
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

//function for date picker

  _selectDate(
    BuildContext context,
  ) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: documentsController.selectdateStatus == "issue"
            ? documentsController.selectedissueDate != null
                ? documentsController.selectedissueDate
                : DateTime.now()
            : documentsController.selectedissueDate != null
                ? documentsController.selectedissueDate
                : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      if (documentsController.selectdateStatus == "issue") {
        documentsController.selectedissueDate = newSelectedDate;
        issueDateController
          ..text =
              DateFormat('yyyy-MM-dd').format(documentsController.selectedissueDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: issueDateController.text.length,
              affinity: TextAffinity.upstream));
      } else if (documentsController.selectdateStatus == "expiry") {
        documentsController.selectedexpiryDate = newSelectedDate;
        expiryDateController
          ..text =
              DateFormat('yyyy-MM-dd').format(documentsController.selectedexpiryDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: expiryDateController.text.length,
              affinity: TextAffinity.upstream));
      }
    }
  }
 
}
