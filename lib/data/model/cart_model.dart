import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/data/model/cart_item_model.dart';
import 'package:shamoapps/domain/entity/cart.dart';

part 'cart_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CartModel {
  final int id;
  final String secret;
  final List<CartItemModel>? items;
  final int? totalPrice;

  CartModel({
    required this.id,
    required this.secret,
    this.items,
    this.totalPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  Cart map() => Cart(
        id: id,
        secret: secret,
        items: items?.map((i) => i.map()).toList() ?? [],
        totalPrice: totalPrice ?? 0,
      );
}