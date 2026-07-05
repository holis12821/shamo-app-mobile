import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/cart.dart';
import 'package:shamoapps/domain/repository/cart_repository.dart';

class AddToCart implements UseCase<Cart, AddToCartParams> {
  final CartRepository repository;
  AddToCart(this.repository);

  @override
  Future<Either<Failure, Cart>> call(AddToCartParams params) =>
      repository.addToCart(
        productId: params.productId,
        quantity: params.quantity,
      );
}

class AddToCartParams extends Equatable {
  final int productId;
  final int quantity;

  const AddToCartParams({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}