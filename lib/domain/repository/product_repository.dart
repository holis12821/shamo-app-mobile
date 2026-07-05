import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/domain/entity/category.dart';
import 'package:shamoapps/domain/entity/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    String? categories,
    String? name,
    int? page,
    int? limit,
  });

  Future<Either<Failure, Product>> getProductDetail(int id);

  Future<Either<Failure, List<Category>>> getCategories();
}