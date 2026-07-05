import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/core/storage/cart_storage.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/cart.dart';
import 'package:shamoapps/domain/usecase/add_to_cart.dart';
import 'package:shamoapps/domain/usecase/create_cart.dart';
import 'package:shamoapps/domain/usecase/delete_cart_item.dart';
import 'package:shamoapps/domain/usecase/get_cart.dart';
import 'package:shamoapps/domain/usecase/update_cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCart getCart;
  final CreateCart createCart;
  final AddToCart addToCart;
  final UpdateCartItem updateCartItem;
  final DeleteCartItem deleteCartItem;
  final CartStorage cartStorage;

  CartBloc({
    required this.getCart,
    required this.createCart,
    required this.addToCart,
    required this.updateCartItem,
    required this.deleteCartItem,
    required this.cartStorage,
  }) : super(const CartInitial()) {
    on<CartLoad>(_onLoad);
    on<CartAddItem>(_onAddItem);
    on<CartUpdateItem>(_onUpdateItem);
    on<CartDeleteItem>(_onDeleteItem);
  }

  Future<void> _onLoad(CartLoad event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    final hasCart = await cartStorage.hasCart();
    if (!hasCart) {
      emit(const CartEmpty());
      return;
    }
    final result = await getCart(const NoParams());
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) =>
          cart.items.isEmpty ? emit(const CartEmpty()) : emit(CartLoaded(cart)),
    );
  }

  Future<void> _onAddItem(CartAddItem event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    // Create cart first if none exists
    final hasCart = await cartStorage.hasCart();
    if (!hasCart) {
      final createResult = await createCart(const NoParams());
      final failed = createResult.fold<bool>(
        (failure) {
          emit(CartError(failure.message));
          return true;
        },
        (_) => false,
      );
      if (failed) return;
    }
    final result = await addToCart(AddToCartParams(
      productId: event.productId,
      quantity: event.quantity,
    ));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart)),
    );
  }

  Future<void> _onUpdateItem(
      CartUpdateItem event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    final result = await updateCartItem(UpdateCartItemParams(
      itemId: event.itemId,
      quantity: event.quantity,
    ));
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) =>
          cart.items.isEmpty ? emit(const CartEmpty()) : emit(CartLoaded(cart)),
    );
  }

  Future<void> _onDeleteItem(
      CartDeleteItem event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    final result = await deleteCartItem(event.itemId);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) => add(const CartLoad()),
    );
  }
}