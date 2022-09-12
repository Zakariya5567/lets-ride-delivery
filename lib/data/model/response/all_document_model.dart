// To parse this JSON data, do
//
//     final allDocumentModel = allDocumentModelFromJson(jsonString);

import 'dart:convert';

AllDocumentModel allDocumentModelFromJson(String str) => AllDocumentModel.fromJson(json.decode(str));

String allDocumentModelToJson(AllDocumentModel data) => json.encode(data.toJson());

class AllDocumentModel {
    AllDocumentModel({
        this.data,
        this.result,
    });

    List<Datum> data;
    Result result;

    factory AllDocumentModel.fromJson(Map<String, dynamic> json) => AllDocumentModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "result": result.toJson(),
    };
}

class Datum {
    Datum({
        this.id,
        this.documentName,
        this.userId,
        this.companyId,
        this.documentStatus,
        this.documentNo,
        this.imageUrlFront,
        this.imageUrlBack,
        this.docTypeId,
        this.issueDate,
        this.expiryDate,
        this.createdAt,
        this.updatedAt,
        this.documentStatusName,
    });

    int id;
    String documentName;
    int userId;
    int companyId;
    int documentStatus;
    String documentNo;
    String imageUrlFront;
    String imageUrlBack;
    int docTypeId;
    DateTime issueDate;
    DateTime expiryDate;
    DateTime createdAt;
    DateTime updatedAt;
    String documentStatusName;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        documentName: json["document_name"],
        userId: json["user_id"],
        companyId: json["restaurant_id"],
        documentStatus: json["document_status"],
        documentNo: json["document_no"],
        imageUrlFront: json["image_url_front"],
        imageUrlBack: json["image_url_back"],
        docTypeId: json["doc_type_id"],
        issueDate: DateTime.parse(json["issue_date"]),
        expiryDate: DateTime.parse(json["expiry_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        documentStatusName: json["doc_status_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "document_name": documentName,
        "user_id": userId,
        "restaurant_id": companyId,
        "document_status": documentStatus,
        "document_no": documentNo,
        "image_url_front": imageUrlFront,
        "image_url_back": imageUrlBack,
        "doc_type_id": docTypeId,
        "issue_date": "${issueDate.year.toString().padLeft(4, '0')}-${issueDate.month.toString().padLeft(2, '0')}-${issueDate.day.toString().padLeft(2, '0')}",
        "expiry_date": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "doc_status_name":documentStatusName,
    };
}

class Result {
    Result({
        this.code,
        this.message,
        this.description,
        this.rflag,
    });

    int code;
    String message;
    String description;
    int rflag;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["Code"],
        message: json["Message"],
        description: json["Description"],
        rflag: json["Rflag"],
    );

    Map<String, dynamic> toJson() => {
        "Code": code,
        "Message": message,
        "Description": description,
        "Rflag": rflag,
    };
}
