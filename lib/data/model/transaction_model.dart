import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/domain/entity/transaction.dart';

part 'transaction_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TransactionModel {
  final int id;
  final String? orderNumber;
  final String? status;
  final int? totalPrice;
  final String? address;
  final String? createdAt;

  TransactionModel({
    required this.id,
    this.orderNumber,
    this.status,
    this.totalPrice,
    this.address,
    this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  Transaction map() => Transaction(
        id: id,
        orderNumber: orderNumber ?? '',
        status: status ?? '',
        totalPrice: totalPrice ?? 0,
        address: address ?? '',
        createdAt: createdAt ?? '',
      );
}