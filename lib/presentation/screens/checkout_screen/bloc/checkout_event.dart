part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class CheckoutSubmit extends CheckoutEvent {
  final String address;
  const CheckoutSubmit({required this.address});

  @override
  List<Object?> get props => [address];
}