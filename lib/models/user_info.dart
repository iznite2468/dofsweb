class UserInfo {
  int? userAccessId;
  String? username;
  String? password;
  int? userLevelId;
  String? status;
  String? verificationCode;
  String? fcmToken;
  int? userInfoId;
  String? fname;
  String? mname;
  String? lname;
  String? completeAddress;
  String? city;
  String? contactNumber;
  String? email;

  UserInfo(
      {this.userAccessId,
      this.username,
      this.password,
      this.userLevelId,
      this.status,
      this.verificationCode,
      this.fcmToken,
      this.userInfoId,
      this.fname,
      this.mname,
      this.lname,
      this.completeAddress,
      this.city,
      this.contactNumber,
      this.email});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userAccessId = json['user_access_id'];
    username = json['username'];
    password = json['password'];
    userLevelId = json['user_level_id'];
    status = json['status'];
    verificationCode = json['verification_code'];
    fcmToken = json['fcm_token'];
    userInfoId = json['user_info_id'];
    fname = json['fname'];
    mname = json['mname'];
    lname = json['lname'];
    completeAddress = json['complete_address'];
    city = json['city'];
    contactNumber = json['contact_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_access_id'] = userAccessId;
    data['username'] = username;
    data['password'] = password;
    data['user_level_id'] = userLevelId;
    data['status'] = status;
    data['verification_code'] = verificationCode;
    data['fcm_token'] = fcmToken;
    data['user_info_id'] = userInfoId;
    data['fname'] = fname;
    data['mname'] = mname;
    data['lname'] = lname;
    data['complete_address'] = completeAddress;
    data['city'] = city;
    data['contact_number'] = contactNumber;
    data['email'] = email;
    return data;
  }

  static List<UserInfo> fromList(List rawList) {
    var list = <UserInfo>[];
    if (rawList.isEmpty) return list;

    for (var item in rawList) {
      list.add(UserInfo.fromJson(item));
    }

    return list;
  }

  String fullName() {
    if (mname!.isNotEmpty) {
      return '$fname $mname $lname';
    } else {
      return '$fname $lname';
    }
  }
}
