const baseUrl = "https://doctordofs.herokuapp.com";
//const apiKey = 'AIzaSyBWTd2luV6qL0ICamAIcVunwQ5UQ9xbGpg';
const apiKey = 'AIzaSyC7mD6bJzvnfnb6TCk7Akh3XXg7-wR8JTc';

bool isEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(email);
}
