import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/network/error_mapper.dart';
import 'package:shamoapps/data/data_source/cart_remote_data_source.dart';
import 'package:shamoapps/domain/entity/cart.dart';
import 'package:shamoapps/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remote;
  CartRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, Cart>> createCart() async {
    try {
      final model = await remote.createCart();
      return Right(model.map());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, Cart>> getCart() async {
    try {
      final model = await remote.getCart();
      return Right(model.map());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, Cart>> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final model =
          await remote.addToCart(productId: productId, quantity: quantity);
      return Right(model.map());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, Cart>> updateCartItem({
    required int itemId,
    required int quantity,
  }) async {
    try {
      final model =
          await remote.updateCartItem(itemId: itemId, quantity: quantity);
      return Right(model.map());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCartItem({required int itemId}) async {
    try {
      await remote.deleteCartItem(itemId: itemId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, void>> claimCart() async {
    try {
      await remote.claimCart();
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }
}