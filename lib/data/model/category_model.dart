import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/domain/entity/category.dart';

part 'category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryModel {
  final int id;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  Category map() {
    return Category(id: id, name: name);
  }
}