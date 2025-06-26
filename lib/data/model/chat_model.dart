import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/data/model/product_model.dart';
import 'package:shamoapps/domain/entity/chat.dart';

part 'chat_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChatModel {
  ChatType? type;
  String? text;
  SenderType? sender;
  ProductModel? product;

  ChatModel();

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  Chat mapToMessage() {
    return Chat.message(
      text ?? '',
      sender ?? SenderType.sender,
    );
  }

  Chat mapToProduct() {
    return Chat.product(
      product?.map(),
      sender ?? SenderType.sender,
    );
  }
}
