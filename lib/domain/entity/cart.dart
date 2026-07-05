import 'package:equatable/equatable.dart';
import 'package:shamoapps/domain/entity/cart_item.dart';

class Cart extends Equatable {
  final int id;
  final String secret;
  final List<CartItem> items;
  final int totalPrice;

  const Cart({
    required this.id,
    required this.secret,
    this.items = const [],
    this.totalPrice = 0,
  });

  @override
  List<Object?> get props => [id, secret, items, totalPrice];
}