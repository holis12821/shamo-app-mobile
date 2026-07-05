import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/network/error_mapper.dart';
import 'package:shamoapps/data/data_source/transaction_remote_data_source.dart';
import 'package:shamoapps/domain/entity/transaction.dart';
import 'package:shamoapps/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remote;
  TransactionRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions() async {
    try {
      final models = await remote.getTransactions();
      return Right(models.map((m) => m.map()).toList());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }
}