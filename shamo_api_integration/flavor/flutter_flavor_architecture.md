# Flutter Flavor Architecture — Implementation Spec

> Spec ini ditujukan untuk di-prompt ke Claude Code AI. Tujuannya: membangun
> struktur multi-flavor (`dev`, `staging`, `uat`, `prod`) dengan base URL
> terkunci per-lingkungan, dan URL ngrok dev yang dapat di-override tanpa
> menyentuh source code.

## Konteks & Prinsip Desain

Terapkan prinsip berikut secara ketat — ini adalah keputusan arsitektur, bukan preferensi gaya:

1. **Konfigurasi per-lingkungan hidup di dalam entrypoint flavor (di kode, terkunci), BUKAN di file `.env` terpisah per-branch.** Jangan buat `.env.dev`, `.env.staging`, dst.
2. **Hanya base URL dev (ngrok) yang volatile.** Nilai ini di-override lewat `--dart-define`, karena URL ngrok free berubah tiap restart tunnel. Semua URL lingkungan lain (`staging`/`uat`/`prod`) adalah konstan dan di-hardcode di entrypoint masing-masing.
3. **JANGAN gunakan `flutter_dotenv`.** Dengan flavor, package itu redundan dan menambah sumber kebenaran yang bisa konflik. Satu mekanisme (`--dart-define` untuk dev) lebih bersih.
4. **Flavor harus terdeklarasi di layer native (Android Gradle), bukan hanya di Dart.** Entrypoint `main_*.dart` saja tidak cukup — `flutter run --flavor dev` akan gagal jika Gradle tidak mengenal flavor tersebut.

## Struktur File Target

```
lib/
├── main_dev.dart
├── main_staging.dart
├── main_uat.dart
├── main_prod.dart
├── app.dart
└── config/
    └── app_config.dart
```

## 1. `lib/config/app_config.dart`

Definisi enum lingkungan dan config singleton yang di-set sekali di entrypoint.

```dart
enum Environment { dev, staging, uat, prod }

class AppConfig {
  final Environment environment;
  final String baseUrl;
  final bool enableLogging;

  const AppConfig({
    required this.environment,
    required this.baseUrl,
    required this.enableLogging,
  });

  // Singleton yang di-set sekali di entrypoint sebelum runApp()
  static late AppConfig _instance;
  static AppConfig get instance => _instance;

  static void initialize(AppConfig config) {
    _instance = config;
  }

  bool get isProd => environment == Environment.prod;
}
```

## 2. `lib/main_dev.dart`

URL ngrok HANYA tinggal di sini, di-override via `--dart-define=NGROK_URL=...`.

**Catatan compile-time penting:** `String.fromEnvironment` menghasilkan nilai `const`, dan `const AppConfig(...)` mensyaratkan semua argumennya `const`. Struktur ini valid karena `String.fromEnvironment` memang const. JANGAN mencampur nilai runtime ke dalam constructor const ini — compiler akan menolak.

```dart
import 'package:flutter/material.dart';
import 'app.dart';
import 'config/app_config.dart';

void main() {
  AppConfig.initialize(const AppConfig(
    environment: Environment.dev,
    baseUrl: String.fromEnvironment(
      'NGROK_URL',
      defaultValue: 'https://placeholder.ngrok-free.app',
    ),
    enableLogging: true,
  ));

  runApp(const MyApp());
}
```

## 3. `lib/main_staging.dart`

URL hardcoded, tidak ada `.env`, tidak ada `--dart-define`.

```dart
import 'package:flutter/material.dart';
import 'app.dart';
import 'config/app_config.dart';

void main() {
  AppConfig.initialize(const AppConfig(
    environment: Environment.staging,
    baseUrl: 'https://staging-api.ottencoffee.co.id',
    enableLogging: true,
  ));

  runApp(const MyApp());
}
```

## 4. `lib/main_uat.dart`

```dart
import 'package:flutter/material.dart';
import 'app.dart';
import 'config/app_config.dart';

void main() {
  AppConfig.initialize(const AppConfig(
    environment: Environment.uat,
    baseUrl: 'https://uat-api.ottencoffee.co.id',
    enableLogging: true,
  ));

  runApp(const MyApp());
}
```

## 5. `lib/main_prod.dart`

`enableLogging: false` untuk produksi.

```dart
import 'package:flutter/material.dart';
import 'app.dart';
import 'config/app_config.dart';

void main() {
  AppConfig.initialize(const AppConfig(
    environment: Environment.prod,
    baseUrl: 'https://api.ottencoffee.co.id',
    enableLogging: false,
  ));

  runApp(const MyApp());
}
```

## 6. `lib/app.dart`

Root widget yang membaca config.

```dart
import 'package:flutter/material.dart';
import 'config/app_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otten Coffee',
      debugShowCheckedModeBanner: !AppConfig.instance.isProd,
      home: const HomeScreen(),
    );
  }
}
```

## 7. Android Native Flavor — `android/app/build.gradle`

WAJIB. Tanpa ini `flutter run --flavor dev` akan error karena Gradle tidak mengenal flavor.

`applicationIdSuffix` membuat dev/staging/uat/prod dapat terinstal berdampingan di satu device (package name berbeda), sangat membantu QA membandingkan build.

```groovy
android {
    flavorDimensions "environment"

    productFlavors {
        dev {
            dimension "environment"
            applicationIdSuffix ".dev"
            resValue "string", "app_name", "Otten Dev"
        }
        staging {
            dimension "environment"
            applicationIdSuffix ".staging"
            resValue "string", "app_name", "Otten Staging"
        }
        uat {
            dimension "environment"
            applicationIdSuffix ".uat"
            resValue "string", "app_name", "Otten UAT"
        }
        prod {
            dimension "environment"
            resValue "string", "app_name", "Otten Coffee"
        }
    }
}
```

> **iOS:** mekanismenya berbeda (Xcode schemes + xcconfig). Jika target iOS diperlukan, minta setup terpisah — tidak bisa disamakan dengan Android.

## 8. Cara Menjalankan

Flag `-t` menunjuk entrypoint Dart, `--flavor` menunjuk flavor native. Keduanya HARUS cocok.

```bash
# Dev dengan URL ngrok (ganti URL cukup di sini, tanpa sentuh source)
flutter run \
  --flavor dev \
  -t lib/main_dev.dart \
  --dart-define=NGROK_URL=https://xxxx.ngrok-free.app

# Staging — tidak perlu dart-define, URL sudah terkunci di kode
flutter run --flavor staging -t lib/main_staging.dart

# UAT
flutter run --flavor uat -t lib/main_uat.dart

# Prod
flutter run --flavor prod -t lib/main_prod.dart
```

## 9. VS Code Launch Config (opsional, direkomendasikan)

Supaya tidak mengetik flag panjang berulang. Buat `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "dev (ngrok)",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_dev.dart",
      "args": [
        "--flavor", "dev",
        "--dart-define=NGROK_URL=https://xxxx.ngrok-free.app"
      ]
    },
    {
      "name": "staging",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_staging.dart",
      "args": ["--flavor", "staging"]
    },
    {
      "name": "uat",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_uat.dart",
      "args": ["--flavor", "uat"]
    },
    {
      "name": "prod",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_prod.dart",
      "args": ["--flavor", "prod"]
    }
  ]
}
```

## Acceptance Criteria

- [ ] Keempat entrypoint (`main_dev`, `main_staging`, `main_uat`, `main_prod`) memanggil `AppConfig.initialize()` sebelum `runApp()`.
- [ ] `productFlavors` di `build.gradle` mendeklarasikan 4 flavor dengan `flavorDimensions "environment"`.
- [ ] `applicationIdSuffix` berbeda untuk dev/staging/uat sehingga bisa co-install; prod tanpa suffix.
- [ ] Base URL ngrok HANYA muncul di `main_dev.dart` via `String.fromEnvironment('NGROK_URL', ...)`, tidak di-hardcode.
- [ ] Tidak ada dependency `flutter_dotenv` dan tidak ada file `.env` apa pun.
- [ ] `flutter run --flavor dev -t lib/main_dev.dart --dart-define=NGROK_URL=...` berjalan tanpa error Gradle.
