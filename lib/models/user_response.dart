class User {
  int? userID;
  String? firstName;
  String? lastName;
  String? password;
  String? mobile;
  int? roleID;
  bool? isActive;
  String? roleName;
  String? createdBy;
  String? createdDate;

  User({
    this.userID,
    this.firstName,
    this.lastName,
    this.password,
    this.mobile,
    this.roleID,
    this.isActive,
    this.roleName,
    this.createdBy,
    this.createdDate,
  });

  User.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    password = json['Password'];
    mobile = json['Mobile'];
    roleID = json['RoleID'];
    isActive = json['IsActive'];
    roleName = json['RoleName'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserID'] = userID;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Password'] = password;
    data['Mobile'] = mobile;
    data['RoleID'] = roleID;
    data['IsActive'] = isActive;
    data['RoleName'] = roleName;
    data['CreatedBy'] = createdBy;
    data['CreatedDate'] = createdDate;
    return data;
  }
}
