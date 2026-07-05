import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/domain/entity/category.dart';
import 'package:shamoapps/domain/entity/product.dart';
import 'package:shamoapps/domain/usecase/get_categories.dart';
import 'package:shamoapps/domain/usecase/get_products.dart';
import 'package:shamoapps/core/usecases/usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProducts getProducts;
  final GetCategories getCategories;

  HomeBloc({required this.getProducts, required this.getCategories})
      : super(const HomeInitial()) {
    on<HomeLoadProducts>(_onLoadProducts);
    on<HomeCategoryChanged>(_onCategoryChanged);
  }

  Future<void> _onLoadProducts(
    HomeLoadProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    final categoriesResult = await getCategories(const NoParams());
    final productsResult =
        await getProducts(const GetProductsParams());

    final categories = categoriesResult.fold(
      (_) => <Category>[],
      (cats) => cats,
    );

    productsResult.fold(
      (failure) => emit(HomeError(failure.message)),
      (products) => emit(HomeLoaded(
        products: products,
        categories: categories,
      )),
    );
  }

  Future<void> _onCategoryChanged(
    HomeCategoryChanged event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    final categories =
        currentState is HomeLoaded ? currentState.categories : <Category>[];

    emit(const HomeLoading());

    final result = await getProducts(
      GetProductsParams(categories: event.category),
    );

    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (products) => emit(HomeLoaded(
        products: products,
        categories: categories,
        selectedCategory: event.category,
      )),
    );
  }
}