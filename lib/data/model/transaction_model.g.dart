// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: (json['id'] as num).toInt(),
      orderNumber: json['order_number'] as String?,
      status: json['status'] as String?,
      totalPrice: (json['total_price'] as num?)?.toInt(),
      address: json['address'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'status': instance.status,
      'total_price': instance.totalPrice,
      'address': instance.address,
      'created_at': instance.createdAt,
    };
