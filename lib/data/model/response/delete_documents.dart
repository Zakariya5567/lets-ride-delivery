// To parse this JSON data, do
//
//     final deleteDocumentModel = deleteDocumentModelFromJson(jsonString);

import 'dart:convert';

DeleteDocumentModel deleteDocumentModelFromJson(String str) => DeleteDocumentModel.fromJson(json.decode(str));

String deleteDocumentModelToJson(DeleteDocumentModel data) => json.encode(data.toJson());

class DeleteDocumentModel {
    DeleteDocumentModel({
        this.data,
        this.result,
    });

    Data data;
    Result result;

    factory DeleteDocumentModel.fromJson(Map<String, dynamic> json) => DeleteDocumentModel(
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        documentName: json["document_name"],
        userId: json["user_id"],
        companyId: json["company_id"],
        documentStatus: json["document_status"],
        documentNo: json["document_no"],
        imageUrlFront: json["image_url_front"],
        imageUrlBack: json["image_url_back"],
        docTypeId: json["doc_type_id"],
        issueDate: DateTime.parse(json["issue_date"]),
        expiryDate: DateTime.parse(json["expiry_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "document_name": documentName,
        "user_id": userId,
        "company_id": companyId,
        "document_status": documentStatus,
        "document_no": documentNo,
        "image_url_front": imageUrlFront,
        "image_url_back": imageUrlBack,
        "doc_type_id": docTypeId,
        "issue_date": "${issueDate.year.toString().padLeft(4, '0')}-${issueDate.month.toString().padLeft(2, '0')}-${issueDate.day.toString().padLeft(2, '0')}",
        "expiry_date": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Result {
    Result({
        this.code,
        this.message,
    });

    String code;
    String message;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}
