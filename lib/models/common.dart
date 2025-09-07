class ChangeStatusResponse {
  bool? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  ChangeStatusResponse({
    this.data,
    this.message,
    this.errors,
    this.status,
    this.hasError,
    this.hasInfo,
  });

  ChangeStatusResponse.fromJson(Map<String, dynamic> json) {
    data = json['Data'];
    message = json['Message'] != null
        ? Message.fromJson(json['Message'])
        : null;
    if (json['Errors'] != null) {
      errors = <Message>[];
      json['Errors'].forEach((v) {
        errors!.add(Message.fromJson(v));
      });
    }
    status = json['Status'];
    hasError = json['HasError'];
    hasInfo = json['HasInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Data'] = this.data;
    if (message != null) {
      data['Message'] = message!.toJson();
    }
    if (errors != null) {
      data['Errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['Status'] = status;
    data['HasError'] = hasError;
    data['HasInfo'] = hasInfo;
    return data;
  }
}

class FileUploadResponse {
  FileUploadData? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  FileUploadResponse({
    this.data,
    this.message,
    this.errors,
    this.status,
    this.hasError,
    this.hasInfo,
  });

  FileUploadResponse.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? FileUploadData.fromJson(json['Data']) : null;
    message = json['Message'] != null
        ? Message.fromJson(json['Message'])
        : null;
    if (json['Errors'] != null) {
      errors = <Message>[];
      json['Errors'].forEach((v) {
        errors!.add(Message.fromJson(v));
      });
    }
    status = json['Status'];
    hasError = json['HasError'];
    hasInfo = json['HasInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    if (message != null) {
      data['Message'] = message!.toJson();
    }
    if (errors != null) {
      data['Errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['Status'] = status;
    data['HasError'] = hasError;
    data['HasInfo'] = hasInfo;
    return data;
  }
}

class FileUploadData {
  String? fileName;
  String? fileKey;
  String? fileUrl;

  FileUploadData({this.fileName, this.fileKey, this.fileUrl});

  FileUploadData.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
    fileKey = json['FileKey'];
    fileUrl = json['FileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FileName'] = fileName;
    data['FileKey'] = fileKey;
    data['FileUrl'] = fileUrl;
    return data;
  }
}


class SaveMasterResponse {
  int? data;
  Message? message;
  List<Message>? errors;
  String? status;
  bool? hasError;
  bool? hasInfo;

  SaveMasterResponse({
    this.data,
    this.message,
    this.errors,
    this.status,
    this.hasError,
    this.hasInfo,
  });

  SaveMasterResponse.fromJson(Map<String, dynamic> json) {
    data = json['Data'];
    message = json['Message'] != null
        ? Message.fromJson(json['Message'])
        : null;
    if (json['Errors'] != null) {
      errors = <Message>[];
      json['Errors'].forEach((v) {
        errors!.add(Message.fromJson(v));
      });
    }
    status = json['Status'];
    hasError = json['HasError'];
    hasInfo = json['HasInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Data'] = this.data;
    if (message != null) {
      data['Message'] = message!.toJson();
    }
    if (errors != null) {
      data['Errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['Status'] = status;
    data['HasError'] = hasError;
    data['HasInfo'] = hasInfo;
    return data;
  }
}

class Message {
  String? type;
  String? code;
  String? message;

  Message({this.type, this.code, this.message});

  Message.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    code = json['Code'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Type'] = type;
    data['Code'] = code;
    data['Message'] = message;
    return data;
  }
}
