import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/domain/entity/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<Transaction>>> getTransactions();
}