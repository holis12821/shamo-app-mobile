import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, void>> submitCheckout({required String address});
}