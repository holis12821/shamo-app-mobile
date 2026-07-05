import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/cart.dart';
import 'package:shamoapps/domain/repository/cart_repository.dart';

class UpdateCartItem implements UseCase<Cart, UpdateCartItemParams> {
  final CartRepository repository;
  UpdateCartItem(this.repository);

  @override
  Future<Either<Failure, Cart>> call(UpdateCartItemParams params) =>
      repository.updateCartItem(
        itemId: params.itemId,
        quantity: params.quantity,
      );
}

class UpdateCartItemParams extends Equatable {
  final int itemId;
  final int quantity;

  const UpdateCartItemParams({required this.itemId, required this.quantity});

  @override
  List<Object?> get props => [itemId, quantity];
}