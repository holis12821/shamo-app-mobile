part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartLoad extends CartEvent {
  const CartLoad();
}

class CartAddItem extends CartEvent {
  final int productId;
  final int quantity;

  const CartAddItem({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}

class CartUpdateItem extends CartEvent {
  final int itemId;
  final int quantity;

  const CartUpdateItem({required this.itemId, required this.quantity});

  @override
  List<Object?> get props => [itemId, quantity];
}

class CartDeleteItem extends CartEvent {
  final int itemId;

  const CartDeleteItem(this.itemId);

  @override
  List<Object?> get props => [itemId];
}