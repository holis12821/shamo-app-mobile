part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoadProducts extends HomeEvent {
  const HomeLoadProducts();
}

class HomeCategoryChanged extends HomeEvent {
  final String? category;
  const HomeCategoryChanged({this.category});

  @override
  List<Object?> get props => [category];
}