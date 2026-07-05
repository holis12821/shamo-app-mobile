import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/data/model/user_model.dart';

part 'auth_response_model.g.dart';

/// Shared by login and register responses.
/// Parse from `json['data']`.
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AuthResponseModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final UserModel user;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}