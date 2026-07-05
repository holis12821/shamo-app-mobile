import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartStorage {
  static const _cartIdKey = 'cart_id';
  static const _cartSecretKey = 'cart_secret';

  final FlutterSecureStorage _storage;
  CartStorage(this._storage);

  Future<String?> getCartId() => _storage.read(key: _cartIdKey);

  Future<String?> getCartSecret() => _storage.read(key: _cartSecretKey);

  Future<bool> hasCart() async {
    final id = await getCartId();
    return id != null;
  }

  /// Persist the cart identifying values returned by POST /api/cart.
  /// Verify the actual response key names against the live API before calling.
  Future<void> save({
    required String cartId,
    required String cartSecret,
  }) async {
    await _storage.write(key: _cartIdKey, value: cartId);
    await _storage.write(key: _cartSecretKey, value: cartSecret);
  }

  Future<void> clear() async {
    await _storage.delete(key: _cartIdKey);
    await _storage.delete(key: _cartSecretKey);
  }
}