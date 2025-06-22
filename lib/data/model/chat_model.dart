import 'package:json_annotation/json_annotation.dart';
import 'package:shamoapps/domain/entity/chat.dart';

part 'chat_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChatModel {
  ChatType? type;
  String? text;
  SenderType? sender;
  String? productName;
  String? imageUrl;
  double? price;

  ChatModel();

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  Chat mapToMessage() {
    return Chat.message(
      text: text,
      sender: sender,
    );
  }

  Chat mapToProduct() {
    return Chat.product(
      productName: productName,
      imageUrl: imageUrl,
      price: price,
    );
  }
}
