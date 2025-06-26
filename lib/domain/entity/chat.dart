import 'package:shamoapps/domain/entity/product.dart';

enum ChatType { message, product }

enum SenderType { sender, receiver }

class Chat {
  final ChatType type;
  final String? text;
  final Product? product;
  final SenderType? sender;

  Chat({
    required this.type,
    this.text,
    this.product,
    required this.sender,
  });

  factory Chat.message(String text, SenderType sender) => Chat(
        type: ChatType.message,
        text: text,
        sender: sender,
      );

  factory Chat.product(Product? product, SenderType sender) => Chat(
        type: ChatType.product,
        product: product,
        sender: sender,
      );
}
