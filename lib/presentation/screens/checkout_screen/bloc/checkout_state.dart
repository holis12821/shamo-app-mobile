part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

class CheckoutSuccess extends CheckoutState {
  const CheckoutSuccess();
}

class CheckoutError extends CheckoutState {
  final String message;
  const CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}