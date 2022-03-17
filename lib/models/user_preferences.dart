class UserPreferences {
  int? userAccessId;
  String? fullName;
  String? username;
  int? userLevelId;
  String? token;

  UserPreferences(
      {this.userAccessId,
      this.fullName,
      this.username,
      this.userLevelId,
      this.token});

  UserPreferences.fromJson(Map<String, dynamic> json) {
    userAccessId = json['userAccessId'];
    fullName = json['fullName'];
    username = json['username'];
    userLevelId = json['userLevelId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userAccessId'] = userAccessId;
    data['fullName'] = fullName;
    data['username'] = username;
    data['userLevelId'] = userLevelId;
    data['token'] = token;
    return data;
  }
}
