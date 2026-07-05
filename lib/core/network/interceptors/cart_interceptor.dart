import 'package:dio/dio.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/storage/cart_storage.dart';

/// Attaches `X-CART-ID` and `X-CART-SECRET` headers to all cart and checkout
/// requests that operate on an existing cart.
///
/// The only exception is `POST /api/cart` (create cart), which runs before a
/// cart exists and therefore carries no cart headers.
///
/// Per backend confirmation, both headers are **required** on every cart
/// endpoint operating on an existing cart (read, add, update, delete, claim)
/// including PUT and DELETE, which the source spec wrongly omitted.
/// If either header is missing, the interceptor fails fast with
/// [CartSessionFailure] rather than sending an incomplete request.
class CartInterceptor extends Interceptor {
  final CartStorage _cartStorage;

  CartInterceptor({required CartStorage cartStorage})
      : _cartStorage = cartStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final path = options.path;
    final isCartOrCheckout = path.contains('/api/cart') ||
        path.contains('/api/order/checkout');

    if (!isCartOrCheckout) return handler.next(options);

    // POST /api/cart (create cart): cart doesn't exist yet — no headers
    if (_isCreateCart(path, options.method)) return handler.next(options);

    final cartId = await _cartStorage.getCartId();
    final cartSecret = await _cartStorage.getCartSecret();

    if (cartId == null || cartSecret == null) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const CartSessionFailure(
            'Cart session not found. Create a cart first via POST /api/cart.',
          ),
          type: DioExceptionType.unknown,
        ),
        true,
      );
    }

    options.headers['X-CART-ID'] = cartId;
    options.headers['X-CART-SECRET'] = cartSecret;
    handler.next(options);
  }

  /// Returns true for `POST /api/cart` (exact path, no sub-path).
  bool _isCreateCart(String path, String method) {
    final bare = path.split('?').first.replaceAll(RegExp(r'/$'), '');
    return bare.endsWith('/api/cart') && method.toUpperCase() == 'POST';
  }
}