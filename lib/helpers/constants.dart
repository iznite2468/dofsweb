const baseUrl = "https://doctordofs.herokuapp.com";
//const apiKey = 'AIzaSyBWTd2luV6qL0ICamAIcVunwQ5UQ9xbGpg';
const apiKey = 'AIzaSyC7mD6bJzvnfnb6TCk7Akh3XXg7-wR8JTc';

bool isEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(email);
}

String format(String value) {
  var formatted = value.split('/');
  var year = formatted[formatted.length - 1];
  var day = formatted[1].length <= 1 ? '0${formatted[1]}' : formatted[1];
  var month = formatted[0].length <= 1 ? '0${formatted[0]}' : formatted[0];

  return '$year-$month-$day';
}
