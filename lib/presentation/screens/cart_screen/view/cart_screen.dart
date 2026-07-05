import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/core/di/service_locator.dart';
import 'package:shamoapps/presentation/screens/cart_screen/bloc/cart_bloc.dart';
import 'package:shamoapps/presentation/screens/cart_screen/view/cart_view.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CartBloc>()..add(const CartLoad()),
      child: const CartView(),
    );
  }
}