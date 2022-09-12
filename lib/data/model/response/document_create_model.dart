// To parse this JSON data, do
//
//     final createDocumentModel = createDocumentModelFromJson(jsonString);

import 'dart:convert';

CreateDocumentModel createDocumentModelFromJson(String str) => CreateDocumentModel.fromJson(json.decode(str));

String createDocumentModelToJson(CreateDocumentModel data) => json.encode(data.toJson());

class CreateDocumentModel {
    CreateDocumentModel({
        this.data,
        this.result,
    });

    Data data;
    Result result;

    factory CreateDocumentModel.fromJson(Map<String, dynamic> json) => CreateDocumentModel(
        data: Data.fromJson(json["data"]),
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "result": result.toJson(),
    };
}

class Data {
    Data({
        this.documentNo,
        this.documentName,
        this.expiryDate,
        this.companyId,
        this.issueDate,
        this.docTypeId,
        this.imageUrlFront,
        this.imageUrlBack,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.userId,
    });

    String documentNo;
    String documentName;
    DateTime expiryDate;
    String companyId;
    DateTime issueDate;
    String docTypeId;
    String imageUrlFront;
    String imageUrlBack;
    DateTime updatedAt;
    DateTime createdAt;
    int id;
    String userId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        documentNo: json["document_no"],
        documentName: json["document_name"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        companyId: json["company_id"],
        issueDate: DateTime.parse(json["issue_date"]),
        docTypeId: json["doc_type_id"],
        imageUrlFront: json["image_url_front"],
        imageUrlBack: json["image_url_back"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "document_no": documentNo,
        "document_name": documentName,
        "expiry_date": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "company_id": companyId,
        "issue_date": "${issueDate.year.toString().padLeft(4, '0')}-${issueDate.month.toString().padLeft(2, '0')}-${issueDate.day.toString().padLeft(2, '0')}",
        "doc_type_id": docTypeId,
        "image_url_front": imageUrlFront,
        "image_url_back": imageUrlBack,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "user_id": userId,
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
