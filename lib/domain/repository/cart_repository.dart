import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/domain/entity/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> createCart();
  Future<Either<Failure, Cart>> getCart();
  Future<Either<Failure, Cart>> addToCart({
    required int productId,
    required int quantity,
  });
  Future<Either<Failure, Cart>> updateCartItem({
    required int itemId,
    required int quantity,
  });
  Future<Either<Failure, void>> deleteCartItem({required int itemId});
  Future<Either<Failure, void>> claimCart();
}