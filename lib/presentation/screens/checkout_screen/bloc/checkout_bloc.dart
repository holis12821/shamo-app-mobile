import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/domain/usecase/submit_checkout.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final SubmitCheckout submitCheckout;

  CheckoutBloc(this.submitCheckout) : super(const CheckoutInitial()) {
    on<CheckoutSubmit>(_onSubmit);
  }

  Future<void> _onSubmit(
    CheckoutSubmit event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(const CheckoutLoading());
    final result = await submitCheckout(
      SubmitCheckoutParams(address: event.address),
    );
    result.fold(
      (failure) => emit(CheckoutError(failure.message)),
      (_) => emit(const CheckoutSuccess()),
    );
  }
}