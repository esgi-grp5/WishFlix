import 'package:uuid/uuid.dart';

// Create uuid object
const uuid = Uuid();

class User {
  User({this.token = ""});

  String token;

  int id = uuid.v4().hashCode;

  getToken() {
    // Appel api pour demander token
  }
}
