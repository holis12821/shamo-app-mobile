part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class ProductDetailLoad extends ProductDetailEvent {
  final int productId;
  const ProductDetailLoad(this.productId);

  @override
  List<Object?> get props => [productId];
}