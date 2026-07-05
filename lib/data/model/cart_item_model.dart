import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/data/model/product_model.dart';
import 'package:shamoapps/domain/entity/cart_item.dart';

part 'cart_item_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CartItemModel {
  final int id;
  final int quantity;
  final ProductModel product;

  CartItemModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  CartItem map() => CartItem(
        id: id,
        quantity: quantity,
        product: product.map(),
      );
}