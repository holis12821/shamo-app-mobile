// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel()
  ..type = $enumDecodeNullable(_$ChatTypeEnumMap, json['type'])
  ..text = json['text'] as String?
  ..sender = $enumDecodeNullable(_$SenderTypeEnumMap, json['sender'])
  ..product = json['product'] == null
      ? null
      : ProductModel.fromJson(json['product'] as Map<String, dynamic>);

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'type': _$ChatTypeEnumMap[instance.type],
      'text': instance.text,
      'sender': _$SenderTypeEnumMap[instance.sender],
      'product': instance.product,
    };

const _$ChatTypeEnumMap = {
  ChatType.message: 'message',
  ChatType.product: 'product',
};

const _$SenderTypeEnumMap = {
  SenderType.sender: 'sender',
  SenderType.receiver: 'receiver',
};
