class UserData {
  int? isAdmin;
  int? userAccessId;
  final String? username;
  final String? password;
  final String? fname;
  final String? mname;
  final String? lname;
  final String? completeAddress;
  final String? email;
  final String? contactNumber;

  UserData({
    this.isAdmin,
    this.userAccessId,
    this.username,
    this.password,
    this.fname,
    this.mname,
    this.lname,
    this.completeAddress,
    this.email,
    this.contactNumber,
  });

  toJson() {
    return {
      'isAdmin': isAdmin,
      'userAccessId': userAccessId,
      'username': username,
      'password': password,
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'completeAddress': completeAddress,
      'email': email,
      'contactNumber': contactNumber,
    };
  }
}
