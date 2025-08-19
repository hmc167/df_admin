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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Code'] = this.code;
    data['Message'] = this.message;
    return data;
  }
}
