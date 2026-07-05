import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/product.dart';
import 'package:shamoapps/domain/repository/product_repository.dart';

class GetProductDetail implements UseCase<Product, int> {
  final ProductRepository repository;
  GetProductDetail(this.repository);

  @override
  Future<Either<Failure, Product>> call(int params) =>
      repository.getProductDetail(params);
}