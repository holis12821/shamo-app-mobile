# Layer Templates Reference

Skeletons that match **this project's** conventions (see `PROJECT_STRUCTURE.md` /
`CLAUDE.md`): layer-first folders, `@JsonSerializable(fieldRename: snake)` models
with a `map()` to entities (models do NOT extend entities), `dartz Either`,
`get_it` (`sl`), `flutter_bloc ^7` with sealed-style BLoC states (separate Equatable
classes under an abstract base), and
`flutter_secure_storage`. Adapt names to the endpoint; do not introduce new
dependencies.

## Core: Failure (Equatable) and UseCase

```dart
// core/error/failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}
class ServerFailure extends Failure { const ServerFailure(super.m); }
class NetworkFailure extends Failure { const NetworkFailure(super.m); }
class AuthFailure extends Failure { const AuthFailure(super.m); }
class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;
  const ValidationFailure(super.m, {this.fieldErrors});
  @override
  List<Object?> get props => [message, fieldErrors];
}
class CartSessionFailure extends Failure { const CartSessionFailure(super.m); }
```

```dart
// core/usecases/usecase.dart
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
class NoParams { const NoParams(); }
```

## Config

```dart
// core/config/app_config.dart
class AppConfig {
  // IP (10.0.2.2 emulator / LAN IP for physical) or ngrok URL.
  static const String baseUrl = String.fromEnvironment('API_BASE_URL');
  static const bool useNgrok = bool.fromEnvironment('API_USE_NGROK', defaultValue: false);
  static const String valetHost = 'shamoapps.test';
}
```

## Domain: entity, repository contract, use case

```dart
// domain/entity/product.dart  — pure Dart, Equatable, no JSON
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final int price;
  final String description;   // raw HTML; rendered in presentation
  final String formattedPrice; // e.g. "Rp 1.070.490"
  final Category category;
  final List<Gallery> galleries;
  const Product({
    required this.id, required this.name, required this.price,
    required this.description, required this.formattedPrice,
    required this.category, required this.galleries,
  });
  @override
  List<Object?> get props => [id, name, price, description, formattedPrice, category, galleries];
}
```

```dart
// domain/repository/product_repository.dart
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entity/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    String? categories, String? name, int? page, int? limit,
  });
}
```

```dart
// domain/usecase/get_products.dart
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entity/product.dart';
import '../repository/product_repository.dart';

class GetProducts implements UseCase<List<Product>, GetProductsParams> {
  final ProductRepository repository;
  GetProducts(this.repository);
  @override
  Future<Either<Failure, List<Product>>> call(GetProductsParams p) =>
      repository.getProducts(
        categories: p.categories, name: p.name, page: p.page, limit: p.limit,
      );
}
class GetProductsParams {
  final String? categories; final String? name; final int? page; final int? limit;
  const GetProductsParams({this.categories, this.name, this.page, this.limit});
}
```

## Data: model (@JsonSerializable + map), data source, repository impl

Models use `fieldRename: FieldRename.snake`, so a Dart field `accessToken` maps to
the wire key `access_token` automatically. Each model exposes a hand-written
`map()` returning the entity. Run
`dart run build_runner build --delete-conflicting-outputs` after edits.

```dart
// data/model/product_model.dart
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/product.dart';
part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProductModel {
  final int id;
  final String name;
  final int price;
  final String? description;
  final CategoryModel category;
  final List<GalleryModel> galleries;
  @JsonKey(name: 'formatted') final FormattedModel? formatted;

  ProductModel({
    required this.id, required this.name, required this.price,
    this.description, required this.category, required this.galleries,
    this.formatted,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  // Model → Entity. Models do NOT extend entities in this project.
  Product map() => Product(
    id: id,
    name: name,
    price: price,
    description: description ?? '',
    formattedPrice: formatted?.price ?? '',
    category: category.map(),
    galleries: galleries.map((g) => g.map()).toList(),
  );
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FormattedModel {
  final String? price;
  FormattedModel({this.price});
  factory FormattedModel.fromJson(Map<String, dynamic> j) => _$FormattedModelFromJson(j);
  Map<String, dynamic> toJson() => _$FormattedModelToJson(this);
}
```

```dart
// data/data_source/product_remote_data_source.dart
import 'package:dio/dio.dart';
import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    String? categories, String? name, int? page, int? limit,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio; // the main ApiClient Dio (with interceptors)
  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getProducts({
    String? categories, String? name, int? page, int? limit,
  }) async {
    final res = await dio.get('/api/product/products', queryParameters: {
      if (categories != null) 'categories': categories,
      if (name != null) 'name': name,
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
    });
    // Envelope confirmed against live API:
    //   list       -> res.data['data']['products']   (NOT 'items')
    //   pagination -> res.data['meta']['pagination']  (lives in meta)
    final data = res.data['data'] as Map<String, dynamic>;
    final list = (data['products'] as List).cast<Map<String, dynamic>>();
    return list.map(ProductModel.fromJson).toList();
    // Non-2xx is thrown by Dio and mapped in the repository.
  }
}
```

```dart
// data/repository/product_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/error/failures.dart';
import '../../core/network/error_mapper.dart';
import '../../domain/entity/product.dart';
import '../../domain/repository/product_repository.dart';
import '../data_source/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  ProductRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    String? categories, String? name, int? page, int? limit,
  }) async {
    try {
      final models = await remote.getProducts(
        categories: categories, name: name, page: page, limit: limit,
      );
      return Right(models.map((m) => m.map()).toList()); // Model → Entity
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }
}
```

## Auth & User models (confirmed against live login + refresh)

```dart
// data/model/user_model.dart
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/user.dart';
part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final int id;
  final String name;
  final String email;
  final String username;
  final String? phone;
  final String? roles;                 // STRING (e.g. "USER"), NOT a list
  final String? emailVerifiedAt;       // nullable on the wire
  final String? twoFactorConfirmedAt;  // nullable
  final int? currentTeamId;            // nullable
  final String? profilePhotoPath;      // nullable
  final String? profilePhotoUrl;       // always present in practice
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    required this.id, required this.name, required this.email,
    required this.username, this.phone, this.roles,
    this.emailVerifiedAt, this.twoFactorConfirmedAt, this.currentTeamId,
    this.profilePhotoPath, this.profilePhotoUrl, this.createdAt, this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> j) => _$UserModelFromJson(j);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User map() => User(
    id: id, name: name, email: email, username: username,
    phone: phone ?? '', roles: roles ?? '',
    profilePhotoUrl: profilePhotoUrl ?? '',
  );
}
```

```dart
// data/model/auth_response_model.dart  — shared by login & register
import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';
part 'auth_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AuthResponseModel {
  final String accessToken;   // <- access_token
  final String refreshToken;  // <- refresh_token
  final String tokenType;     // <- token_type ("Bearer")
  final UserModel user;       // present on login/register

  AuthResponseModel({
    required this.accessToken, required this.refreshToken,
    required this.tokenType, required this.user,
  });

  // Pass json['data'].
  factory AuthResponseModel.fromJson(Map<String, dynamic> j) =>
      _$AuthResponseModelFromJson(j);
  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}
```

## Networking: ApiClient + interceptors (separate refreshDio)

> **Dio Host caveat:** setting `'Host'` in `BaseOptions.headers` is unreliable —
> `dart:io` HttpClient may drop/overwrite it (dio issue #1577). Set it in the
> interceptor `onRequest`, build Dio with `preserveHeaderCase: true`, and verify via
> a logging interceptor that the request actually carries `Host: shamoapps.test` in
> direct-to-Valet modes.

```dart
// core/network/api_client.dart
import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/cart_interceptor.dart';

class ApiClient {
  late final Dio dio;        // main instance (with interceptors)
  late final Dio refreshDio; // NO interceptors — used only for /api/refresh

  ApiClient(/* TokenStorage tokenStorage, CartStorage cartStorage */) {
    final base = BaseOptions(
      baseUrl: AppConfig.baseUrl,
      preserveHeaderCase: true,
      headers: {'Accept': 'application/json'},
    );
    dio = Dio(base);
    refreshDio = Dio(base); // separate: avoids recursive interception on refresh

    dio.interceptors.add(CartInterceptor(/* cartStorage */));
    dio.interceptors.add(AuthInterceptor(/* tokenStorage, refreshDio */));
  }
}
```

```dart
// core/network/interceptors/auth_interceptor.dart  (sketch)
// - onRequest: attach Host (skip if AppConfig.useNgrok); attach Bearer access
//   token EXCEPT on /register, /login, /refresh.
// - onError (401, and not already /refresh): single-flight refresh via refreshDio:
//     POST /api/refresh with Authorization: Bearer <refresh_token>.
//     Response is { access_token, token_type } ONLY — no refresh_token (not
//     rotated), no user. Save the new access token, keep the old refresh token,
//     retry the original request ONCE. A second 401 -> AuthFailure (clear session).
// - Guard concurrent 401s with a single-flight lock so only one refresh runs.
```

```dart
// core/network/interceptors/cart_interceptor.dart  (sketch)
// - onRequest: if path needs cart headers (all cart/checkout EXCEPT POST /api/cart),
//   read cart id+secret from CartStorage and attach:
//     X-CART-ID    (single string)   — on read, add, update, delete, claim
//     X-CART-SECRET                   — on ALL of the above (required, confirmed)
//   If required and missing -> reject with CartSessionFailure (fail fast).
```

## Central error mapper (three response shapes + non-JSON)

```dart
// core/network/error_mapper.dart
import 'package:dio/dio.dart';
import '../error/failures.dart';

Failure mapDioExceptionToFailure(DioException e) {
  // A CartSessionFailure rejected in an interceptor arrives as e.error.
  if (e.error is Failure) return e.error as Failure;

  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.connectionError) {
    return const NetworkFailure('Network problem, please try again');
  }
  final status = e.response?.statusCode;
  final body = e.response?.data;

  // Non-JSON body: Valet/nginx HTML ("Valet - Not Found") or shape #3 (bare
  // string on 500). Never feed these to fromJson.
  if (body is String) return const ServerFailure('Server error');

  if (body is Map<String, dynamic>) {
    final meta = body['meta'] as Map<String, dynamic>?;
    final data = body['data'];
    // Shape #2: nested { message, error } (seen on 401 register).
    if (data is Map<String, dynamic> && data['error'] != null) {
      return ValidationFailure(data['error'].toString());
    }
    final msg = (meta?['message'] ?? 'Request failed').toString();
    if (status == 401) return AuthFailure(msg);
    if (status == 422) return ValidationFailure(msg);
    return ServerFailure(msg);
  }
  return const ServerFailure('Unexpected server response');
}
```

## Presentation: BLoC (sealed-style states, flutter_bloc ^7)

States are a hierarchy of **separate classes** under one base type
(`Initial / Loading / Loaded / Error`), each `Equatable`. The base is an
`abstract class`, not the `sealed` keyword, because `flutter_bloc ^7` predates
Dart 3 and `sealed` won't compile on Dart 2.x. If the project is on Dart 3+, you may
switch `abstract` → `sealed` to get compiler-enforced exhaustiveness in
`switch`/`is` handling. All other project conventions are unchanged: events are a
`sealed`/`abstract` Equatable hierarchy, handlers are registered in the constructor
as private async methods, and the Screen/View split stays.

```dart
// presentation/screens/home_screen/bloc/home_event.dart
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}
class LoadProducts extends HomeEvent {
  final String? category;
  const LoadProducts({this.category});
  @override
  List<Object?> get props => [category];
}
```

```dart
// presentation/screens/home_screen/bloc/home_state.dart
import 'package:equatable/equatable.dart';
import '../../../../domain/entity/product.dart';

// Base state. Use `abstract` for Dart 2.x / flutter_bloc ^7 compatibility.
// On Dart 3+, `sealed` may be used instead for exhaustiveness checks.
abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Product> products;
  const HomeLoaded(this.products);
  @override
  List<Object?> get props => [products];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [message];
}
```

```dart
// presentation/screens/home_screen/bloc/home_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecase/get_products.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProducts getProducts;
  HomeBloc(this.getProducts) : super(const HomeInitial()) {
    on<LoadProducts>(_onLoadProducts); // handlers registered in constructor
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    final result = await getProducts(GetProductsParams(categories: event.category));
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (products) => emit(HomeLoaded(products)),
    );
  }
}
```

In the view, switch on the concrete state type:

```dart
// inside HomeView build()
BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    if (state is HomeLoading) return const Center(child: CircularProgressIndicator());
    if (state is HomeError)   return Center(child: Text(state.message));
    if (state is HomeLoaded)  return ProductGrid(products: state.products);
    return const SizedBox.shrink(); // HomeInitial
  },
)
```
```

```dart
// presentation/screens/home_screen/view/home_screen.dart  (BlocProvider wrapper)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<HomeBloc>()..add(const LoadProducts()),
    child: const HomeView(),
  );
}
```

## DI registration (get_it, in service_locator.dart)

```dart
// core/di/service_locator.dart (excerpt — match existing style)
void _registerProductFeature() {
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl<ApiClient>().dio));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerFactory(() => HomeBloc(sl())); // BLoC as factory
}
```

## Test expectations (per endpoint)

- **Model test:** `fromJson` then `map()` yields the expected entity; a nullable
  field absent in JSON maps to the entity's default (e.g. `roles` "" if missing).
- **Repository test:** returns `Right(entity)` on success; returns the correct
  `Failure` for network error, 401, 422, and a non-JSON/500 body.
- **BLoC test:** on `LoadProducts`, emits `[HomeLoading(), HomeLoaded(products)]`
  on success and `[HomeLoading(), HomeError(message)]` on failure, using a mocked
  use case.
