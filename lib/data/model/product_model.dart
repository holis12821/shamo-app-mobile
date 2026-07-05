import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/data/model/category_model.dart';
import 'package:shamoapps/data/model/gallery_model.dart';
import 'package:shamoapps/domain/entity/product.dart';

part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProductModel {
  final int id;
  final String name;
  final int price;
  final String? description;
  final String? tags;
  final int? categoriesId;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: 'formatted')
  final FormattedModel? formatted;
  final CategoryModel? category;
  final List<GalleryModel>? galleries;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.tags,
    this.categoriesId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.formatted,
    this.category,
    this.galleries,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  Product map() {
    return Product(
      id: id,
      name: name,
      price: price,
      description: description ?? '',
      formattedPrice: formatted?.price ?? '',
      category: category?.map(),
      galleries: galleries?.map((g) => g.map()).toList() ?? [],
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FormattedModel {
  final String? price;

  FormattedModel({this.price});

  factory FormattedModel.fromJson(Map<String, dynamic> json) =>
      _$FormattedModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormattedModelToJson(this);
}