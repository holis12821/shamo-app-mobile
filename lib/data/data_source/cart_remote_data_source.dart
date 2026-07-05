import 'package:dio/dio.dart';
import 'package:shamoapps/core/storage/cart_storage.dart';
import 'package:shamoapps/data/model/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> createCart();
  Future<CartModel> getCart();
  Future<CartModel> addToCart({required int productId, required int quantity});
  Future<CartModel> updateCartItem({required int itemId, required int quantity});
  Future<void> deleteCartItem({required int itemId});
  Future<void> claimCart();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final Dio dio;
  final CartStorage cartStorage;

  CartRemoteDataSourceImpl({required this.dio, required this.cartStorage});

  @override
  Future<CartModel> createCart() async {
    final response = await dio.post('/api/cart');
    final data = response.data['data'] as Map<String, dynamic>;
    final model = CartModel.fromJson(data);
    // Persist cart credentials for future requests
    await cartStorage.save(
      cartId: model.id.toString(),
      cartSecret: model.secret,
    );
    return model;
  }

  @override
  Future<CartModel> getCart() async {
    final response = await dio.get('/api/cart');
    final data = response.data['data'] as Map<String, dynamic>;
    return CartModel.fromJson(data);
  }

  @override
  Future<CartModel> addToCart({
    required int productId,
    required int quantity,
  }) async {
    final response = await dio.post('/api/cart/items', data: {
      'product_id': productId,
      'quantity': quantity,
    });
    final data = response.data['data'] as Map<String, dynamic>;
    return CartModel.fromJson(data);
  }

  @override
  Future<CartModel> updateCartItem({
    required int itemId,
    required int quantity,
  }) async {
    final response = await dio.put('/api/cart/items/$itemId', data: {
      'quantity': quantity,
    });
    final data = response.data['data'] as Map<String, dynamic>;
    return CartModel.fromJson(data);
  }

  @override
  Future<void> deleteCartItem({required int itemId}) async {
    await dio.delete('/api/cart/items/$itemId');
  }

  @override
  Future<void> claimCart() async {
    await dio.post('/api/cart/claim');
  }
}