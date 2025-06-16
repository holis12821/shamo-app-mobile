import 'package:flutter/material.dart';
import 'package:shamoapps/presentation/widgets/categories_widget.dart';
import 'package:shamoapps/presentation/widgets/header_widget.dart';
import 'package:shamoapps/presentation/widgets/new_arrivals_widget.dart';
import 'package:shamoapps/presentation/widgets/popular_products_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
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
  }
}
