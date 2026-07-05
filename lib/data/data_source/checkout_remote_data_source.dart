import 'package:dio/dio.dart';

abstract class CheckoutRemoteDataSource {
  Future<void> submitCheckout({required String address});
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final Dio dio;
  CheckoutRemoteDataSourceImpl(this.dio);

  @override
  Future<void> submitCheckout({required String address}) async {
    await dio.post('/api/order/checkout', data: {'address': address});
  }
}