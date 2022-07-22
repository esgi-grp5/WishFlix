
class User {
  static final User _user = User._internal();
  late int id;
  late String username;
  late String mail;
  late String md5Pw;
  late bool isConnected;
  factory User() {
    return _user;
  }

  User._internal();

  void fromData(userData) {
    _user.id = userData["id"];
    _user.username = userData["username"];
    _user.mail = userData["mail"];
    _user.md5Pw = userData["password"];
  }

  String getUsername() {
    return _user.username;
  }

  String getMail() {
    return _user.mail;
  }

  String getMD5Pw() {
    return _user.md5Pw;
  }

  int getId() {
    return _user.id;
  }

  void setIsConnected() {
    isConnected = true;
  }

  void setIsDisconnected() {
    isConnected = false;
  }


}