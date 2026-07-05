import 'package:equatable/equatable.dart';
import 'package:shamoapps/domain/entity/category.dart';
import 'package:shamoapps/domain/entity/gallery.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final int price;
  final String description;
  final String formattedPrice;
  final Category? category;
  final List<Gallery> galleries;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.description = '',
    this.formattedPrice = '',
    this.category,
    this.galleries = const [],
  });

  /// Convenience getter — first gallery URL, or empty string if none.
  String get imageUrl =>
      galleries.isNotEmpty ? galleries.first.url : '';

  @override
  List<Object?> get props =>
      [id, name, price, description, formattedPrice, category, galleries];
}