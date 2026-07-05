import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/network/error_mapper.dart';
import 'package:shamoapps/data/data_source/product_remote_data_source.dart';
import 'package:shamoapps/domain/entity/category.dart';
import 'package:shamoapps/domain/entity/product.dart';
import 'package:shamoapps/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  ProductRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    String? categories,
    String? name,
    int? page,
    int? limit,
  }) async {
    try {
      final models = await remote.getProducts(
        categories: categories,
        name: name,
        page: page,
        limit: limit,
      );
      return Right(models.map((m) => m.map()).toList());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetail(int id) async {
    try {
      final model = await remote.getProductDetail(id);
      return Right(model.map());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final models = await remote.getCategories();
      return Right(models.map((m) => m.map()).toList());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }
}