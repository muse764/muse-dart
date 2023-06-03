library user;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  User._();

  factory User([Function(UserBuilder b) updates]) = _$User;

  String get id;
  String get email;
  String get username;

  static Serializer<User> get serializer => _$userSerializer;

  static User fromJson(Map<String, dynamic> json) {
    return User((b) => b
      ..id = json['id']
      ..email = json['email']
      ..username = json['username']);
  }
}
