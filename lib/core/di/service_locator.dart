import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shamoapps/core/config/app_config.dart';
import 'package:shamoapps/core/network/api_client.dart';
import 'package:shamoapps/core/storage/cart_storage.dart';
import 'package:shamoapps/core/storage/token_storage.dart';

// Auth
import 'package:shamoapps/data/data_source/auth_remote_data_source.dart';
import 'package:shamoapps/data/repository/auth_repository_impl.dart';
import 'package:shamoapps/domain/repository/auth_repository.dart';
import 'package:shamoapps/domain/usecase/login.dart';
import 'package:shamoapps/domain/usecase/logout.dart';
import 'package:shamoapps/domain/usecase/register.dart';

// User
import 'package:shamoapps/data/data_source/user_remote_data_source.dart';
import 'package:shamoapps/data/repository/user_repository_impl.dart';
import 'package:shamoapps/domain/repository/user_repository.dart';
import 'package:shamoapps/domain/usecase/get_user.dart';
import 'package:shamoapps/domain/usecase/update_user.dart';

// Product
import 'package:shamoapps/data/data_source/product_remote_data_source.dart';
import 'package:shamoapps/data/repository/product_repository_impl.dart';
import 'package:shamoapps/domain/repository/product_repository.dart';
import 'package:shamoapps/domain/usecase/get_categories.dart';
import 'package:shamoapps/domain/usecase/get_product_detail.dart';
import 'package:shamoapps/domain/usecase/get_products.dart';

// Cart
import 'package:shamoapps/data/data_source/cart_remote_data_source.dart';
import 'package:shamoapps/data/repository/cart_repository_impl.dart';
import 'package:shamoapps/domain/repository/cart_repository.dart';
import 'package:shamoapps/domain/usecase/add_to_cart.dart';
import 'package:shamoapps/domain/usecase/create_cart.dart';
import 'package:shamoapps/domain/usecase/delete_cart_item.dart';
import 'package:shamoapps/domain/usecase/get_cart.dart';
import 'package:shamoapps/domain/usecase/update_cart_item.dart';

// Checkout
import 'package:shamoapps/data/data_source/checkout_remote_data_source.dart';
import 'package:shamoapps/data/repository/checkout_repository_impl.dart';
import 'package:shamoapps/domain/repository/checkout_repository.dart';
import 'package:shamoapps/domain/usecase/submit_checkout.dart';

// Transaction
import 'package:shamoapps/data/data_source/transaction_remote_data_source.dart';
import 'package:shamoapps/data/repository/transaction_repository_impl.dart';
import 'package:shamoapps/domain/repository/transaction_repository.dart';
import 'package:shamoapps/domain/usecase/get_transactions.dart';

// BLoCs
import 'package:shamoapps/presentation/screens/sign_in_screen/bloc/sign_in_bloc.dart';
import 'package:shamoapps/presentation/screens/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:shamoapps/presentation/screens/home_screen/bloc/home_bloc.dart';
import 'package:shamoapps/presentation/screens/product_detail_screen/bloc/product_detail_bloc.dart';
import 'package:shamoapps/presentation/screens/profile_screen/bloc/profile_bloc.dart';
import 'package:shamoapps/presentation/screens/cart_screen/bloc/cart_bloc.dart';
import 'package:shamoapps/presentation/screens/checkout_screen/bloc/checkout_bloc.dart';

final sl = GetIt.instance;

/// Call once in [main] before [runApp].
void setupServiceLocator() {
  const secureStorage = FlutterSecureStorage();

  // Storage
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(secureStorage));
  sl.registerLazySingleton<CartStorage>(() => CartStorage(secureStorage));

  // Network
  sl.registerLazySingleton<Dio>(
    () => ApiClient.create(
      baseUrl: AppConfig.baseUrl,
      tokenStorage: sl<TokenStorage>(),
      cartStorage: sl<CartStorage>(),
    ),
  );

  // ── Auth ──
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<Dio>()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remote: sl<AuthRemoteDataSource>(),
        tokenStorage: sl<TokenStorage>(),
        cartStorage: sl<CartStorage>(),
      ));
  sl.registerLazySingleton(() => Login(sl<AuthRepository>()));
  sl.registerLazySingleton(() => Register(sl<AuthRepository>()));
  sl.registerLazySingleton(() => Logout(sl<AuthRepository>()));

  // ── User ──
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(sl<Dio>()));
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(sl<UserRemoteDataSource>()));
  sl.registerLazySingleton(() => GetUser(sl<UserRepository>()));
  sl.registerLazySingleton(() => UpdateUser(sl<UserRepository>()));

  // ── Product ──
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl<Dio>()));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()));
  sl.registerLazySingleton(() => GetProducts(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetProductDetail(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetCategories(sl<ProductRepository>()));

  // ── Cart ──
  sl.registerLazySingleton<CartRemoteDataSource>(() =>
      CartRemoteDataSourceImpl(dio: sl<Dio>(), cartStorage: sl<CartStorage>()));
  sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(sl<CartRemoteDataSource>()));
  sl.registerLazySingleton(() => CreateCart(sl<CartRepository>()));
  sl.registerLazySingleton(() => GetCart(sl<CartRepository>()));
  sl.registerLazySingleton(() => AddToCart(sl<CartRepository>()));
  sl.registerLazySingleton(() => UpdateCartItem(sl<CartRepository>()));
  sl.registerLazySingleton(() => DeleteCartItem(sl<CartRepository>()));

  // ── Checkout ──
  sl.registerLazySingleton<CheckoutRemoteDataSource>(
      () => CheckoutRemoteDataSourceImpl(sl<Dio>()));
  sl.registerLazySingleton<CheckoutRepository>(
      () => CheckoutRepositoryImpl(sl<CheckoutRemoteDataSource>()));
  sl.registerLazySingleton(() => SubmitCheckout(sl<CheckoutRepository>()));

  // ── Transaction ──
  sl.registerLazySingleton<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl(sl<Dio>()));
  sl.registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(sl<TransactionRemoteDataSource>()));
  sl.registerLazySingleton(() => GetTransactions(sl<TransactionRepository>()));

  // ── BLoCs (factory — new instance per screen) ──
  sl.registerFactory(() => SignInBloc(sl<Login>()));
  sl.registerFactory(() => SignUpBloc(sl<Register>()));
  sl.registerFactory(() => HomeBloc(
        getProducts: sl<GetProducts>(),
        getCategories: sl<GetCategories>(),
      ));
  sl.registerFactory(() => ProductDetailBloc(sl<GetProductDetail>()));
  sl.registerFactory(() => ProfileBloc(
        getUser: sl<GetUser>(),
        logout: sl<Logout>(),
      ));
  sl.registerFactory(() => CartBloc(
        getCart: sl<GetCart>(),
        createCart: sl<CreateCart>(),
        addToCart: sl<AddToCart>(),
        updateCartItem: sl<UpdateCartItem>(),
        deleteCartItem: sl<DeleteCartItem>(),
        cartStorage: sl<CartStorage>(),
      ));
  sl.registerFactory(() => CheckoutBloc(sl<SubmitCheckout>()));
}