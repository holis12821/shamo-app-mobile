import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/domain/entity/user.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final int id;
  final String name;
  final String email;
  final String username;
  final String? phone;
  final String? roles;
  final String? emailVerifiedAt;
  final String? twoFactorConfirmedAt;
  final int? currentTeamId;
  final String? profilePhotoPath;
  final String? profilePhotoUrl;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.phone,
    this.roles,
    this.emailVerifiedAt,
    this.twoFactorConfirmedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    this.profilePhotoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User map() {
    return User(
      id: id,
      name: name,
      email: email,
      username: username,
      phone: phone ?? '',
      roles: roles ?? '',
      profilePhotoUrl: profilePhotoUrl ?? '',
    );
  }
}