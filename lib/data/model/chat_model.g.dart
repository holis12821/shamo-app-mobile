// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel()
  ..type = $enumDecodeNullable(_$ChatTypeEnumMap, json['type'])
  ..text = json['text'] as String?
  ..sender = $enumDecodeNullable(_$SenderTypeEnumMap, json['sender'])
  ..productName = json['product_name'] as String?
  ..imageUrl = json['image_url'] as String?
  ..price = (json['price'] as num?)?.toDouble();

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'type': _$ChatTypeEnumMap[instance.type],
      'text': instance.text,
      'sender': _$SenderTypeEnumMap[instance.sender],
      'product_name': instance.productName,
      'image_url': instance.imageUrl,
      'price': instance.price,
    };

const _$ChatTypeEnumMap = {
  ChatType.message: 'message',
  ChatType.product: 'product',
};

const _$SenderTypeEnumMap = {
  SenderType.sender: 'sender',
  SenderType.receiver: 'receiver',
};
