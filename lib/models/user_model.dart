import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/constants.dart';

class User {
 int? id;
 String? name;
 String? username;
 String? email;
 String? phone;
 String? emailVerifiedAt;
 String? isEmployee;
 String? isSeller;
 String? active;
 String? status;
 String? adminNotes;
 String? lastLogin;
 String? lastLoginIp;
 String? createdAt;
 String? updatedAt;
 String? token;

  User(this.id,this.token,this.name,this.username,this.email,this.phone,this.emailVerifiedAt,this.isEmployee,this.isSeller,this.active,this.status,this.adminNotes,this.lastLogin,this.lastLoginIp,this.createdAt,this.updatedAt);

  User.fromJson(dynamic json)
  {
    id = json["id"];
    token = json["token"];
    name = json["name"];
    username = json["username"];
    email = json["email"];
    phone = json["phone"];
    emailVerifiedAt = json["email_verified_at"];
    isEmployee = json["is_employee"];
    isSeller = json["is_seller"];
    active = json["active"];
    status = json["status"];
    adminNotes = json["admin_notes"];
    lastLogin = json["last_login"];
    lastLoginIp = json["last_login_ip"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String,dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["token"] = token;
    data["name"] = name;
    data["username"] = username;
    data["email"] = email;
    data["phone"] = phone;
    data["email_verified_at"] = emailVerifiedAt;
    data["is_employee"] = isEmployee;
    data["is_seller"] = isSeller;
    data["active"] = active;
    data["status"] = status;
    data["admin_notes"] = adminNotes;
    data["last_login"] = lastLogin;
    data["last_login_ip"] = lastLoginIp;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}
class UserData with ChangeNotifier {
  bool? loggedIn;

 Future<bool?> getLogged() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? loggedIn = await prefs.getBool('loggedIn') ?? false;
  return loggedIn;
}

  var userData = new Map();
  User? _currentUser;


  set setCurrentUser(Map<String, dynamic> user) {
    _currentUser = user != null ? User.fromJson(user) : null;
    saveUser(_currentUser!);
  }
  User? get currentUser => _currentUser;
  Future<void> saveUser(User user) async {


    final LocalStorage storage = LocalStorage("sarekny");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);
      loggedIn =true;

      // save the user Info as local storage
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem("userInfo", user.toJson());
      }
      notifyListeners();
    } catch (err) {

    }
  }
  Future<void> getUser() async {
    final LocalStorage storage = LocalStorage("sarekny");
    try {
      final ready = await storage.ready;

      if (ready) {
        final json = storage.getItem("userInfo");
        print(json);
        if (json != null) {
          _currentUser = User.fromJson(json);
          loggedIn = true;
          notifyListeners();
        }
      }
    } catch (err) {

    }
  }
  Future<void> logout() async {

    _currentUser = null;
    loggedIn = false;
    final LocalStorage storage = LocalStorage("sarekny");
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.deleteItem("userInfo");


        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', false);
        loggedIn =false;
      }

    } catch (err) {

    }
    notifyListeners();
  }


}