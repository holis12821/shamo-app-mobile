import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/repository/checkout_repository.dart';

class SubmitCheckout implements UseCase<void, SubmitCheckoutParams> {
  final CheckoutRepository repository;
  SubmitCheckout(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitCheckoutParams params) =>
      repository.submitCheckout(address: params.address);
}

class SubmitCheckoutParams extends Equatable {
  final String address;
  const SubmitCheckoutParams({required this.address});

  @override
  List<Object?> get props => [address];
}