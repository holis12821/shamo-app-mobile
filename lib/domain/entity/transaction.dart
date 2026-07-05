import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final int id;
  final String orderNumber;
  final String status;
  final int totalPrice;
  final String address;
  final String createdAt;

  const Transaction({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.totalPrice,
    this.address = '',
    this.createdAt = '',
  });

  @override
  List<Object?> get props =>
      [id, orderNumber, status, totalPrice, address, createdAt];
}