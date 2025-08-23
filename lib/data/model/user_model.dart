

import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/domain/entity/User.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? username;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User map() {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      username: username,
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, phone: $phone, username: $username}';
  }
}