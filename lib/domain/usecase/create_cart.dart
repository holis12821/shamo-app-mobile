import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/cart.dart';
import 'package:shamoapps/domain/repository/cart_repository.dart';

class CreateCart implements UseCase<Cart, NoParams> {
  final CartRepository repository;
  CreateCart(this.repository);

  @override
  Future<Either<Failure, Cart>> call(NoParams params) =>
      repository.createCart();
}