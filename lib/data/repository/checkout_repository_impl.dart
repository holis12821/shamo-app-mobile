import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/network/error_mapper.dart';
import 'package:shamoapps/data/data_source/checkout_remote_data_source.dart';
import 'package:shamoapps/domain/repository/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource remote;
  CheckoutRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, void>> submitCheckout({
    required String address,
  }) async {
    try {
      await remote.submitCheckout(address: address);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }
}