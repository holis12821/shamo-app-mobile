import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/product.dart';
import 'package:shamoapps/domain/repository/product_repository.dart';

class GetProducts implements UseCase<List<Product>, GetProductsParams> {
  final ProductRepository repository;
  GetProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(GetProductsParams params) =>
      repository.getProducts(
        categories: params.categories,
        name: params.name,
        page: params.page,
        limit: params.limit,
      );
}

class GetProductsParams extends Equatable {
  final String? categories;
  final String? name;
  final int? page;
  final int? limit;

  const GetProductsParams({this.categories, this.name, this.page, this.limit});

  @override
  List<Object?> get props => [categories, name, page, limit];
}