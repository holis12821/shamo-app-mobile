import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// Title Login
  ///
  /// In id, this message translates to:
  /// **'Login'**
  String get login;

  /// Subtitle dibawah title Login
  ///
  /// In id, this message translates to:
  /// **'Daftar untuk Masuk'**
  String get sign_in_to_continue;

  /// Label untuk form email
  ///
  /// In id, this message translates to:
  /// **'Alamat Email'**
  String get email_address;

  /// Label untuk form nomor telepon
  ///
  /// In id, this message translates to:
  /// **'Nomor Telepon'**
  String get phone_number;

  /// Hint label untuk form nomor telepon
  ///
  /// In id, this message translates to:
  /// **'Cth. 08xxxxxx'**
  String get hint_phone_number;

  /// Label untuk form Password
  ///
  /// In id, this message translates to:
  /// **'Password'**
  String get password;

  /// Hint label untuk form email
  ///
  /// In id, this message translates to:
  /// **'Alamat Email Anda'**
  String get hint_email_address;

  /// Hint label untuk form password
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi Anda'**
  String get hint_password;

  /// Text button untuk login
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get txt_sign_in;

  /// Text untuk footer belum memiliki akun
  ///
  /// In id, this message translates to:
  /// **'Tidak memiliki akun? '**
  String get txt_footer;

  /// Label untuk daftar
  ///
  /// In id, this message translates to:
  /// **'Daftar'**
  String get txt_sign_up;

  /// Subtitle dibawah title Daftar
  ///
  /// In id, this message translates to:
  /// **'Daftar dan Selamat Berbelanja'**
  String get register_and_happy_shopping;

  /// Title untuk nama lengkap
  ///
  /// In id, this message translates to:
  /// **'Nama Lengkap'**
  String get full_name;

  /// Hint label untuk form full name
  ///
  /// In id, this message translates to:
  /// **'Nama Lengkap Anda'**
  String get hint_full_name;

  /// Title untuk nama pengguna
  ///
  /// In id, this message translates to:
  /// **'Nama pengguna'**
  String get username;

  /// Hint label untuk form nama pengguna
  ///
  /// In id, this message translates to:
  /// **'Nama Pengguna Anda'**
  String get hint_username;

  /// Text untuk footer sudah memiliki akun
  ///
  /// In id, this message translates to:
  /// **'Sudah memiliki akun? '**
  String get txt_footer_already_have_account;

  /// Sapaan untuk user yang sudah login
  ///
  /// In id, this message translates to:
  /// **'Halo Alex'**
  String get greetings_hello;

  /// Username untuk user yang sudah login
  ///
  /// In id, this message translates to:
  /// **'@alexkeinn'**
  String get user_name;

  /// Label untuk nama
  ///
  /// In id, this message translates to:
  /// **'Nama'**
  String get name;

  /// Nama pengguna
  ///
  /// In id, this message translates to:
  /// **'Cth. Alex keinnzal'**
  String get name_username;

  /// Title untuk kategori semua sepatu
  ///
  /// In id, this message translates to:
  /// **'Semua Sepatu'**
  String get all_shoes;

  /// Title untuk kategori sepatu lari
  ///
  /// In id, this message translates to:
  /// **'Berlari'**
  String get running_shoes;

  /// Title untuk kategori sepatu basket
  ///
  /// In id, this message translates to:
  /// **'Basket'**
  String get basketball_shoes;

  /// Title untuk kategori sepatu latihan
  ///
  /// In id, this message translates to:
  /// **'Latihan'**
  String get training_shoes;

  /// Title untuk kategori produk populer
  ///
  /// In id, this message translates to:
  /// **'Produk Populer'**
  String get popular_products;

  /// Title untuk kategori sepatu hiking
  ///
  /// In id, this message translates to:
  /// **'Hiking'**
  String get hiking_shoes;

  /// Nama produk sepatu Court Vision 2.0
  ///
  /// In id, this message translates to:
  /// **'Court Vision 2.0'**
  String get court_vision;

  /// Harga produk dalam format nominal Rupiah
  ///
  /// In id, this message translates to:
  /// **'Rp. 1.000.000'**
  String get price_nominal;

  /// Title untuk kategori produk baru
  ///
  /// In id, this message translates to:
  /// **'Produk Baru'**
  String get new_arrivals;

  /// Title untuk dukungan pesan
  ///
  /// In id, this message translates to:
  /// **'Dukungan Pesan'**
  String get message_support;

  /// title wording yang menandakan belum ada pesan
  ///
  /// In id, this message translates to:
  /// **'Opss belum ada pesan?'**
  String get oopss_no_message_yet;

  /// subtitle belum ada transaksi
  ///
  /// In id, this message translates to:
  /// **'Anda belum pernah melakukan transaksi'**
  String get never_done_transaction;

  /// Wording untuk Jelajahi Toko
  ///
  /// In id, this message translates to:
  /// **'Jelajahi Toko'**
  String get explore_store;

  /// Wording toko sepatu
  ///
  /// In id, this message translates to:
  /// **'Toko Sepatu'**
  String get shoe_store;

  /// Wording message chat
  ///
  /// In id, this message translates to:
  /// **'Selamat malam, Item ini sedang aktif...'**
  String get chat_content;

  /// Waktu pesan
  ///
  /// In id, this message translates to:
  /// **'Sekarang'**
  String get now;

  /// Seller yang sedang online pada chat
  ///
  /// In id, this message translates to:
  /// **'Online'**
  String get online;

  /// Ketik Pesan hint text
  ///
  /// In id, this message translates to:
  /// **'Ketik Pesan...'**
  String get typing_txt;

  /// Nama Product
  ///
  /// In id, this message translates to:
  /// **'COURT VISION 2.0 SHOES'**
  String get product_name;

  /// Wording Tambahkan ke Keranjang
  ///
  /// In id, this message translates to:
  /// **'Add to Cart'**
  String get add_to_cart;

  /// Wording Beli Sekarang
  ///
  /// In id, this message translates to:
  /// **'Beli Sekarang'**
  String get buy_now;

  /// message text
  ///
  /// In id, this message translates to:
  /// **'Selamat malam, Item ini hanya tersedia dalam ukuran 42 dan 43'**
  String get chat_message;

  /// Wording Sepatu Favorit
  ///
  /// In id, this message translates to:
  /// **'Sepatu Favorit'**
  String get favorite_shoes;

  /// empty_title_wishlist
  ///
  /// In id, this message translates to:
  /// **' Anda tidak memiliki sepatu impian?'**
  String get empty_wishlist_shoes;

  /// temukan sepatu yang anda suka
  ///
  /// In id, this message translates to:
  /// **'Mari temukan sepatu favorit Anda'**
  String get find_favorite_shoes;

  /// Sapaan untuk pelanggan
  ///
  /// In id, this message translates to:
  /// **'Hallo, Alex'**
  String get greetings_welcome_customer;

  /// Wording untuk Akun
  ///
  /// In id, this message translates to:
  /// **'Account'**
  String get account_wording;

  /// Wording untuk Edit Profil
  ///
  /// In id, this message translates to:
  /// **'Edit Profil'**
  String get edit_profile;

  /// Wording untuk Pesanan Anda
  ///
  /// In id, this message translates to:
  /// **'Pesanan Anda'**
  String get your_orders;

  /// Wording untuk Bantuan
  ///
  /// In id, this message translates to:
  /// **'Bantuan'**
  String get help;

  /// Wording untuk Umum
  ///
  /// In id, this message translates to:
  /// **'Umum'**
  String get general;

  /// Wording untuk Privasi & Kebijakan
  ///
  /// In id, this message translates to:
  /// **'Privasi & Kebijakan'**
  String get privacy_policy;

  /// Wording untuk Syarat & Ketentuan
  ///
  /// In id, this message translates to:
  /// **'Syarat & Ketentuan'**
  String get term_of_service;

  /// Wording untuk Beri Penilaian Aplikasi
  ///
  /// In id, this message translates to:
  /// **'Beri Penilaian Aplikasi'**
  String get rate_app;

  /// Wording untuk error nama
  ///
  /// In id, this message translates to:
  /// **'Nama tidak boleh kosong'**
  String get error_name;

  /// Wording untuk error username
  ///
  /// In id, this message translates to:
  /// **'Username tidak boleh kosong'**
  String get error_username;

  /// Wording untuk error email
  ///
  /// In id, this message translates to:
  /// **'Email tidak valid'**
  String get error_email;

  /// Wording untuk error nomor telepon
  ///
  /// In id, this message translates to:
  /// **'Nomor Hp harus 9 - 12 karakter'**
  String get error_phone;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
