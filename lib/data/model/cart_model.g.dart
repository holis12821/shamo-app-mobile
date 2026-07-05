// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      id: (json['id'] as num).toInt(),
      secret: json['secret'] as String,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['total_price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'id': instance.id,
      'secret': instance.secret,
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'total_price': instance.totalPrice,
    };
