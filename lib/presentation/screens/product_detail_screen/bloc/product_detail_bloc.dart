import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/domain/entity/product.dart';
import 'package:shamoapps/domain/usecase/get_product_detail.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc
    extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetail getProductDetail;

  ProductDetailBloc(this.getProductDetail)
      : super(const ProductDetailInitial()) {
    on<ProductDetailLoad>(_onLoad);
  }

  Future<void> _onLoad(
    ProductDetailLoad event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(const ProductDetailLoading());
    final result = await getProductDetail(event.productId);
    result.fold(
      (failure) => emit(ProductDetailError(failure.message)),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }
}