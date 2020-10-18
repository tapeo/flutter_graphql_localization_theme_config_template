import 'dart:typed_data';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_graphql_localization_theme_config_template/graph/model/user_model.dart';
import 'package:flutter_graphql_localization_theme_config_template/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../db_core.dart';

class UserGraph {
  static Future<void> update(User firebaseUser,
      {@required UserModel user}) async {
    String queryString = """
mutation MyMutation {
  update_user_by_pk(pk_columns: {uid: "${user.uid}"}, _set: ${user.toGraphQl()}) {
    uid
  }
}
    """;

    String token = await firebaseUser.getIdToken(true);

    QueryResult queryResult = await DbCore.getClient(token).query(QueryOptions(
      documentNode: gql(queryString),
    ));

    if (queryResult.hasException) {
      print("query: " + queryString.toString());
      print("exception: " + queryResult.exception.toString());
      throw Exception(queryResult.exception);
    }
  }

  static Future<void> add(User firebaseUser,
      {@required UserModel userModel}) async {
    String queryString = """
    mutation AddUser {
      __typename
        insert_user(objects: ${userModel.toGraphQl()}) {
          returning {
            uid
          }
        }
    }""";

    String token = await firebaseUser.getIdToken(true);

    QueryResult queryResult = await DbCore.getClient(token).query(QueryOptions(
      documentNode: gql(queryString),
    ));

    if (queryResult.hasException) {
      print("query: " + queryString.toString());
      print("exception: " + queryResult.exception.toString());
      throw Exception(queryResult.exception);
    }
  }

  static Future<String> updateImageProfile(User user, Uint8List image) async {
    try {
      final StorageReference storageRef = FirebaseStorage.instance
          .ref()
          .child(environment.isDev ? "dev_" : "" + "image_profiles")
          .child(user.uid + ".jpg");

      final StorageUploadTask uploadTask = storageRef.putData(image);

      var url = await (await uploadTask.onComplete).ref.getDownloadURL();

      await _updateImageProfileDb(user, url.toString());

      return url.toString();
    } catch (e) {
      print("updateImageProfile: $e");
      return null;
    }
  }

  static Future<dynamic> _updateImageProfileDb(
      User firebaseUser, String url) async {
    String queryString = """
mutation Update {
  __typename
  update_user(where: {uid: {_eq: "${firebaseUser.uid}"}}, _set: {image: "$url"}) {
    affected_rows
  }
}
  """;

    String token = await firebaseUser.getIdToken(true);

    QueryResult queryResult = await DbCore.getClient(token).query(QueryOptions(
      documentNode: gql(queryString),
    ));

    if (queryResult.hasException) {
      print("query: " + queryString.toString());
      print("exception: " + queryResult.exception.toString());
      throw Exception(queryResult.exception);
    }

    return true;
  }

  static Future<UserModel> get(User firebaseUser, String uid) async {
    String queryString = """
query GetUser {
  __typename
  user(where: {uid: {_eq: "$uid"}}) {
    fcm_token
    name
    email
    uid
  }
}
  """;

    String token = await firebaseUser.getIdToken(true);

    QueryResult queryResult = await DbCore.getClient(token).query(QueryOptions(
      documentNode: gql(queryString),
    ));

    if (queryResult.hasException) {
      print("query: " + queryString.toString());
      print("exception: " + queryResult.exception.toString());
      throw Exception(queryResult.exception);
    }

    if (queryResult.data["user"].length == 0) {
      return null;
    }

    UserModel user = UserModel.fromMap(queryResult.data["user"][0]);

    return user;
  }

  static Future<List<UserModel>> getAll(User firebaseUser) async {
    String queryString = """
query Users {
  __typename
  user {
    fcm_token
    name
    email
    uid
  }
}
  """;

    String token = await firebaseUser.getIdToken(true);

    QueryResult queryResult = await DbCore.getClient(token).query(QueryOptions(
      documentNode: gql(queryString),
    ));

    if (queryResult.hasException) {
      print("query: " + queryString.toString());
      print("exception: " + queryResult.exception.toString());
      throw Exception(queryResult.exception);
    }

    List<dynamic> usersMap = queryResult.data["user"];

    List<UserModel> users = [];

    for (int i = 0; i < usersMap.length; i++) {
      UserModel user = UserModel.fromMap(usersMap[i]);
      users.add(user);
    }

    return users;
  }
}
