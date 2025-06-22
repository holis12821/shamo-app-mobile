enum ChatType { message, product }

enum SenderType { sender, receiver }

class Chat {
  final ChatType type;
  final String? text;
  final SenderType? sender;

  final String? productName;
  final String? imageUrl;
  final double? price;

  Chat.message({required this.text, required this.sender})
      : type = ChatType.message,
        productName = null,
        imageUrl = null,
        price = null;

  Chat.product({
    required this.productName,
    required this.imageUrl,
    required this.price,
  })  : type = ChatType.product,
        text = null,
        sender = null;
}
