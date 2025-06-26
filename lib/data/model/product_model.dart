import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/domain/entity/product.dart';

part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductModel {
  String? name;
  String? imageUrl;
  double? price;

  ProductModel();

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  Product map() {
    return Product(
      name: name,
      imageUrl: imageUrl,
      price: price,
    );
  }
}
