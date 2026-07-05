// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      phone: json['phone'] as String?,
      roles: json['roles'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      twoFactorConfirmedAt: json['two_factor_confirmed_at'] as String?,
      currentTeamId: (json['current_team_id'] as num?)?.toInt(),
      profilePhotoPath: json['profile_photo_path'] as String?,
      profilePhotoUrl: json['profile_photo_url'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'phone': instance.phone,
      'roles': instance.roles,
      'email_verified_at': instance.emailVerifiedAt,
      'two_factor_confirmed_at': instance.twoFactorConfirmedAt,
      'current_team_id': instance.currentTeamId,
      'profile_photo_path': instance.profilePhotoPath,
      'profile_photo_url': instance.profilePhotoUrl,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
