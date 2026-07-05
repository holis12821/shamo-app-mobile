import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/category.dart';
import 'package:shamoapps/domain/repository/product_repository.dart';

class GetCategories implements UseCase<List<Category>, NoParams> {
  final ProductRepository repository;
  GetCategories(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) =>
      repository.getCategories();
}