import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/repository/cart_repository.dart';

class DeleteCartItem implements UseCase<void, int> {
  final CartRepository repository;
  DeleteCartItem(this.repository);

  @override
  Future<Either<Failure, void>> call(int params) =>
      repository.deleteCartItem(itemId: params);
}