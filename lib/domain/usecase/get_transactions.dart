import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/transaction.dart';
import 'package:shamoapps/domain/repository/transaction_repository.dart';

class GetTransactions implements UseCase<List<Transaction>, NoParams> {
  final TransactionRepository repository;
  GetTransactions(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) =>
      repository.getTransactions();
}