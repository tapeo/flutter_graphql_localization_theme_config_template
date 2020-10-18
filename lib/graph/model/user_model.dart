import 'dart:convert';

class UserModel {
  String uid;
  String name;
  String email;
  String fcmToken;

  UserModel({this.uid, this.name, this.email, this.fcmToken});

  UserModel copyWith({
    String uid,
    String name,
    String email,
    String fcmToken,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'fcm_token': fcmToken,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      fcmToken: map['fcm_token'],
    );
  }

  String toGraphQl() {
    StringBuffer buffer = new StringBuffer();

    buffer.writeln("{");
    buffer.writeln("uid: \"$uid\"");
    buffer.writeln("email: \"$email\"");

    if (name != null) {
      buffer.writeln("name: \"$name\"");
    }

    if (fcmToken != null) {
      buffer.writeln("fcm_token: \"$fcmToken\"");
    }

    buffer.writeln("}");

    return buffer.toString();
  }

  String toJson() => json.encode(toMap());

  static UserModel fromJson(String source) => fromMap(json.decode(source));
}
