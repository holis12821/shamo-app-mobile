import 'package:dio/dio.dart';
import 'package:shamoapps/data/model/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions();
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio dio;
  TransactionRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final response = await dio.get('/api/transaction/transactions');
    final data = response.data['data'] as List;
    return data
        .cast<Map<String, dynamic>>()
        .map(TransactionModel.fromJson)
        .toList();
  }
}