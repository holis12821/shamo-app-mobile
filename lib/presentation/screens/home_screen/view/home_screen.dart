import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/core/di/service_locator.dart';
import 'package:shamoapps/presentation/screens/home_screen/bloc/home_bloc.dart';
import 'package:shamoapps/presentation/widgets/categories_widget.dart';
import 'package:shamoapps/presentation/widgets/header_widget.dart';
import 'package:shamoapps/presentation/widgets/new_arrivals_widget.dart';
import 'package:shamoapps/presentation/widgets/popular_products_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeLoadProducts()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          return const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(),
                CategoriesWidget(),
                PopularProductsWidgets(),
                NewArrivalsWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}