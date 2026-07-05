import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/core/di/service_locator.dart';
import 'package:shamoapps/presentation/screens/checkout_screen/bloc/checkout_bloc.dart';
import 'package:shamoapps/presentation/screens/checkout_screen/view/checkout_view.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CheckoutBloc>(),
      child: const CheckoutView(),
    );
  }
}