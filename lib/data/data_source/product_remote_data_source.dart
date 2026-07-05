import 'package:dio/dio.dart';
import 'package:shamoapps/data/model/category_model.dart';
import 'package:shamoapps/data/model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    String? categories,
    String? name,
    int? page,
    int? limit,
  });

  Future<ProductModel> getProductDetail(int id);

  Future<List<CategoryModel>> getCategories();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;
  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getProducts({
    String? categories,
    String? name,
    int? page,
    int? limit,
  }) async {
    final response = await dio.get('/api/product/products', queryParameters: {
      if (categories != null) 'categories': categories,
      if (name != null) 'name': name,
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
    });
    // Product list lives at data.products (NOT data.items)
    final data = response.data['data'] as Map<String, dynamic>;
    final list = (data['products'] as List).cast<Map<String, dynamic>>();
    return list.map(ProductModel.fromJson).toList();
  }

  @override
  Future<ProductModel> getProductDetail(int id) async {
    final response = await dio.get('/api/product/products/$id');
    final data = response.data['data'] as Map<String, dynamic>;
    return ProductModel.fromJson(data);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get('/api/categories');
    final data = response.data['data'] as List;
    return data
        .cast<Map<String, dynamic>>()
        .map(CategoryModel.fromJson)
        .toList();
  }
}