# Flutter Mobile Development Handbook

> Handbook belajar Flutter dan Dart dari **basic sampai intermediate**, dengan prioritas pada Android. Fokusnya memahami alur aplikasi, state, penyimpanan lokal, API, session, notification, location, permission, lifecycle, debugging, dan proses release — bukan sekadar menghafal API.

Panduan ini memakai **Dart + Flutter + GetX** sebagai jalur utama. Contoh ditujukan terutama untuk Android, tetapi konsep dan banyak package juga mendukung iOS.

> Terakhir ditinjau: **16 November 2026**. Versi package dan konfigurasi Android dapat berubah; selalu cocokkan kembali dengan dokumentasi versi yang kamu pasang.

---

## Daftar Isi

- [Mulai dari sini](#mulai-dari-sini)
- [Peta kemampuan mobile developer](#peta-kemampuan-mobile-developer)
- [1. Setup Flutter dan package](#1-setup-flutter-dan-package)
- [2. Dasar Dart yang wajib dikuasai](#2-dasar-dart-yang-wajib-dikuasai)
- [3. Dasar Flutter dan UI](#3-dasar-flutter-dan-ui)
- [4. Navigation dan routing](#4-navigation-dan-routing)
- [5. State management dengan GetX](#5-state-management-dengan-getx)
- [6. Form dan validasi input](#6-form-dan-validasi-input)
- [7. HTTP request dan REST API](#7-http-request-dan-rest-api)
- [8. Local storage](#8-local-storage)
- [9. Session dan authentication](#9-session-dan-authentication)
- [10. Local notification (Android-first)](#10-local-notification-android-first)
- [11. LBS: Location-Based Services](#11-lbs-location-based-services)
- [12. Permission dan akses fitur perangkat](#12-permission-dan-akses-fitur-perangkat)
- [13. Offline mode, cache, dan sinkronisasi](#13-offline-mode-cache-dan-sinkronisasi)
- [14. File, gambar, dan berbagi konten](#14-file-gambar-dan-berbagi-konten)
- [15. App lifecycle dan pengelolaan resource](#15-app-lifecycle-dan-pengelolaan-resource)
- [16. Struktur project dan arsitektur sederhana](#16-struktur-project-dan-arsitektur-sederhana)
- [17. Error handling dan UX state](#17-error-handling-dan-ux-state)
- [18. Testing dan debugging](#18-testing-dan-debugging)
- [19. Android platform essentials, build, dan release](#19-android-platform-essentials-build-dan-release)
- [20. Project latihan: Personal Life Hub](#20-project-latihan-personal-life-hub)
- [Urutan belajar yang disarankan](#urutan-belajar-yang-disarankan)
- [Checklist kemampuan](#checklist-kemampuan)
- [Kesalahan yang sering terjadi](#kesalahan-yang-sering-terjadi)
- [Referensi resmi](#referensi-resmi)

---

# Mulai dari sini

Kalau baru membuka panduan ini, pahami dulu satu gambaran besar:

**Aplikasi mobile menerima input dari pengguna, mengolah state, membaca atau menyimpan data, lalu menampilkan hasilnya.** Sebagian data berasal dari perangkat, sebagian dari server, dan sebagian hanya hidup sementara di memori.

```text
Pengguna
   │ tap, mengetik, memilih lokasi
   ▼
View / UI (Flutter widgets)
   │ memanggil aksi
   ▼
Controller (GetX)
   │ menjalankan aturan aplikasi
   ▼
Repository
   ├── Remote service ── HTTP request ── Backend / API
   ├── Local storage ── Hive / SQLite / Preferences
   ├── Secure storage ── Token / credential
   └── Device service ── Location / Notification / Camera
```

Jangan mulai dengan menghafal semua package. Mulai dengan memahami **data apa yang sedang dikelola** dan **siapa yang bertanggung jawab mengelolanya**.

### Catatan versi Flutter dan Android

Contoh pada handbook ini memakai pola Flutter yang umum. Namun, ekosistem Flutter terus berubah. Sebelum mengikuti konfigurasi native, periksa versi Flutter, Dart, Android Gradle Plugin (AGP), Gradle Wrapper, Kotlin, dan `compileSdk` pada project kamu.

Mulai Flutter 3.47, Material UI tersedia sebagai package mandiri `material_ui`; pada Flutter 3.50, library Material yang masih berada di dalam Flutter SDK sudah deprecated. Project lama masih dapat memakai import lama selama didukung SDK, tetapi untuk migrasi project baru/modern:

```bash
flutter pub add material_ui
dart fix --apply --code=migrate_design_widgets
```

Import Material setelah migrasi:

```dart
import 'package:material_ui/material_ui.dart';
```

Jangan mencampur tipe `ThemeData`, `ColorScheme`, atau widget Material dari dua library berbeda dalam satu API publik. Ikuti migration guide resmi jika project juga memakai package pihak ketiga yang belum bermigrasi.

> **Android-first:** handbook ini memberi prioritas pada Android. Contoh konfigurasi `AndroidManifest.xml`, Gradle Kotlin DSL (`.kts`), runtime permission, notification channel, dan lifecycle Android dijelaskan lebih rinci. Bagian iOS tetap disebut jika perilakunya berbeda.

## Istilah inti

| Istilah | Arti sederhana | Contoh |
|---|---|---|
| UI / View | Bagian yang dilihat dan digunakan pengguna | Login screen, Home screen |
| State | Kondisi aplikasi saat ini | loading, daftar tugas, user aktif |
| Controller | Tempat mengatur aksi dan state untuk sebuah fitur | `LoginController` |
| Model | Bentuk data di dalam aplikasi | `User`, `Task`, `Product` |
| Service | Kode yang berkomunikasi dengan sistem luar | `ApiService`, `LocationService` |
| Repository | Pintu akses data; menyatukan sumber lokal dan remote | `TaskRepository` |
| Local storage | Penyimpanan di perangkat | Hive, SharedPreferences |
| Session | Status pengguna yang sedang menggunakan aplikasi | sudah login atau belum |
| API | Antarmuka untuk bertukar data dengan server | `GET /tasks` |
| Permission | Izin dari sistem operasi untuk memakai fitur tertentu | lokasi, kamera, notifikasi |

---

# Peta kemampuan mobile developer

Untuk level basic–intermediate, kemampuan berikut sudah membentuk fondasi yang kuat.

| Area | Yang harus bisa dilakukan |
|---|---|
| Dart | Variabel, collection, OOP, null safety, `Future`, `async/await`, JSON |
| Flutter UI | Layout, widget, input, list, grid, responsive UI |
| Navigation | Berpindah screen, mengirim argumen, mengelola back stack |
| State | Memisahkan state UI dari tampilan; memahami GetX |
| Networking | GET/POST, JSON, status code, timeout, error handling |
| Storage | Memilih storage yang tepat dan melakukan CRUD |
| Authentication | Login, restore session, token, logout, session expiry |
| Device features | Notifikasi, lokasi, kamera/file, permission |
| App reliability | Lifecycle, offline state, testing, debugging |
| Delivery | Build APK/AAB, konfigurasi, signing, dan release |

Tidak semua fitur harus digunakan di setiap aplikasi. Developer yang baik bukan developer yang memasang banyak package, tetapi developer yang memilih solusi sesuai kebutuhan.

---

# 1. Setup Flutter dan package

## 1.1 Periksa environment

```bash
flutter doctor
flutter --version
dart --version
```

Buat dan jalankan project:

```bash
flutter create my_app
cd my_app
flutter run
```

Perintah yang sering dipakai:

```bash
flutter pub get       # mengambil dependency dari pubspec.yaml
flutter pub add get   # menambahkan package
flutter pub remove get
flutter analyze       # memeriksa masalah kode
flutter test          # menjalankan test
```

Untuk Android real device, aktifkan **Developer options** dan **USB debugging**, lalu periksa koneksi:

```bash
flutter devices
```

## 1.2 Package yang akan sering ditemui

Tambahkan package saat fitur tersebut benar-benar dibutuhkan. Jangan memasang semuanya dari awal.

| Kebutuhan | Package yang umum dipakai | Fungsi |
|---|---|---|
| State, dependency, routing | [`get`](https://pub.dev/packages/get) | GetX |
| HTTP dasar | [`http`](https://pub.dev/packages/http) | Request ke REST API |
| HTTP lebih lengkap | [`dio`](https://pub.dev/packages/dio) | Interceptor, timeout, upload, cancel request |
| Key-value database | [`hive_ce`](https://pub.dev/packages/hive_ce) + [`hive_ce_flutter`](https://pub.dev/packages/hive_ce_flutter) | Data lokal dan object sederhana |
| Preferensi sederhana | [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Tema, onboarding, pengaturan |
| Data sensitif | [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage) | Token dan credential |
| Database relasional | [`sqflite`](https://pub.dev/packages/sqflite) atau [`drift`](https://pub.dev/packages/drift) | Tabel, relasi, query |
| Hive model generator | [`hive_ce_generator`](https://pub.dev/packages/hive_ce_generator) + `build_runner` | Membuat TypeAdapter untuk model Dart |
| Local notification | [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications) | Notifikasi yang dijadwalkan aplikasi |
| Timezone perangkat | [`flutter_timezone`](https://pub.dev/packages/flutter_timezone) | Membaca timezone perangkat untuk jadwal notifikasi |
| Lokasi/GPS | [`geolocator`](https://pub.dev/packages/geolocator) | Koordinat dan update lokasi |
| Background task | [`workmanager`](https://pub.dev/packages/workmanager) | Pekerjaan tertunda/berulang yang dapat dijadwalkan OS |
| Deep link | [`app_links`](https://pub.dev/packages/app_links) | Membuka screen tertentu dari link |
| Geocoding | [`geocoding`](https://pub.dev/packages/geocoding) | Koordinat ↔ alamat |
| Peta | [`google_maps_flutter`](https://pub.dev/packages/google_maps_flutter) | Menampilkan Google Maps |
| Permission umum | [`permission_handler`](https://pub.dev/packages/permission_handler) | Memeriksa dan meminta izin perangkat |
| Koneksi | [`connectivity_plus`](https://pub.dev/packages/connectivity_plus) | Mengetahui jenis koneksi jaringan |
| Pilih gambar | [`image_picker`](https://pub.dev/packages/image_picker) | Kamera dan galeri |
| Path file | [`path_provider`](https://pub.dev/packages/path_provider) | Folder aplikasi di perangkat |
| Buka URL/aplikasi lain | [`url_launcher`](https://pub.dev/packages/url_launcher) | Browser, email, telepon, dan lainnya |
| Share | [`share_plus`](https://pub.dev/packages/share_plus) | Membuka share sheet sistem |

**Catatan versi:** versi package, minimum Flutter/Dart, Android `compileSdk`, Gradle, dan konfigurasi iOS dapat berubah. Jalankan `flutter pub add <nama-package>` untuk memilih versi yang kompatibel dengan SDK project, lalu baca bagian installation/setup pada dokumentasi versi yang terpasang. Jangan menyalin konfigurasi native dari tutorial lama tanpa memeriksa versinya.

---

# 2. Dasar Dart yang wajib dikuasai

Flutter menggunakan Dart. Kalau fondasi Dart belum kuat, memahami GetX, API, dan storage akan terasa lebih sulit.

## 2.1 Variabel, tipe data, `final`, dan `const`

```dart
String name = 'Ivan';
int age = 22;
double balance = 125000.0;
bool isLoggedIn = false;

final createdAt = DateTime.now(); // Nilai ditentukan saat runtime, tidak dapat diganti.
const appName = 'Life Hub';       // Nilai compile-time yang konstan.
```

- `var`: Dart menyimpulkan tipe dari nilai awal.
- `final`: variabel hanya boleh diberi nilai sekali.
- `const`: nilai konstan sejak compile time.
- `dynamic`: dapat berisi tipe berbeda; gunakan seperlunya karena mengurangi pemeriksaan tipe.

## 2.2 Null safety

Tipe data Dart secara default tidak menerima `null`.

```dart
String username = 'ivan';
String? nickname; // Boleh null.

print(nickname ?? 'Belum punya nickname');
print(nickname?.toUpperCase());
```

Operator penting:

| Operator | Kegunaan |
|---|---|
| `?` | Menandai tipe yang boleh `null` |
| `?.` | Mengakses properti/method jika object tidak null |
| `??` | Memberi nilai pengganti jika null |
| `!` | Memaksa Dart menganggap nilai tidak null; gunakan hanya jika yakin |

## 2.3 Collection: List, Set, dan Map

```dart
final names = <String>['Ayu', 'Bima']; // List: urutan terjaga, boleh duplikat.
final uniqueIds = <int>{1, 2, 3};      // Set: setiap nilai unik.
final scores = <String, int>{          // Map: pasangan key-value.
  'Ayu': 90,
  'Bima': 85,
};

names.add('Citra');
uniqueIds.add(4);
scores['Citra'] = 88;

print(names[0]);
print(scores['Ayu']);
```

Operasi list yang umum:

```dart
items.add(value);
items.addAll(otherItems);
items.insert(0, value);
items.remove(value);
items.removeAt(0);
items.clear();
items.length;
items.contains(value);
```

Looping:

```dart
for (final item in names) {
  print(item);
}

for (var index = 0; index < names.length; index++) {
  print(names[index]);
}
```

## 2.4 Function, class, dan object

```dart
int add(int a, int b) {
  return a + b;
}

class User {
  const User({required this.id, required this.name});

  final int id;
  final String name;

  String greeting() => 'Hello, $name';
}

final user = User(id: 1, name: 'Ivan');
print(user.greeting());
```

Konsep OOP:

| Konsep | Makna |
|---|---|
| Class | Cetak biru untuk membuat object |
| Object | Instance dari class |
| Property | Data/atribut object |
| Method | Function milik class |
| Encapsulation | Membatasi akses langsung ke detail internal |
| Inheritance | Class turunan mewarisi class induk (`extends`) |
| Polymorphism | Tipe induk dapat mewakili object dari tipe turunan |
| Abstraction | Menentukan kontrak tanpa membuka detail implementasi |

Contoh inheritance:

```dart
abstract class Animal {
  void speak();
}

class Cat extends Animal {
  @override
  void speak() => print('Meow');
}
```

Di Dart, nama yang diawali underscore seperti `_balance` bersifat private terhadap **library**, bukan otomatis private hanya untuk satu class.

## 2.5 `Future`, `async`, dan `await`

Operasi seperti membaca file, storage, atau memanggil API membutuhkan waktu. Flutter tidak boleh menunggu operasi itu secara blocking di main thread.

- `Future<T>`: satu hasil yang tersedia nanti.
- `async`: menandai function yang menjalankan operasi asynchronous.
- `await`: menunggu hasil `Future` tanpa memblokir seluruh aplikasi.
- `Stream<T>`: rangkaian nilai dari waktu ke waktu, misalnya perubahan lokasi atau koneksi.

```dart
Future<String> loadUsername() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Ivan';
}

Future<void> main() async {
  final username = await loadUsername();
  print(username);
}
```

Gunakan `try/catch` untuk menangani kegagalan operasi asynchronous.

```dart
try {
  final result = await loadUsername();
  print(result);
} catch (error) {
  print('Gagal memuat data: $error');
}
```

## 2.6 JSON dan model

API biasanya mengirim JSON. Ubah JSON menjadi object model agar data lebih aman dan mudah dibaca.

```dart
class Profile {
  const Profile({required this.id, required this.name});

  final int id;
  final String name;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
```

---

# 3. Dasar Flutter dan UI

## 3.1 Kerangka aplikasi

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: const HomePage(),
    );
  }
}
```

Flutter membangun UI dari widget. Widget adalah deklarasi tampilan, bukan elemen visual yang harus dikelola secara manual.

## 3.2 Stateless vs Stateful

| Widget | Gunakan ketika |
|---|---|
| `StatelessWidget` | UI hanya bergantung pada input yang diterima dan tidak menyimpan state lokal yang berubah |
| `StatefulWidget` | Widget perlu menyimpan state lokal dan memperbarui tampilan dengan `setState` |

Contoh `setState`:

```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Count: $count')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => count++),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

`setState` meminta Flutter membangun ulang bagian widget yang dikelola oleh `State` tersebut.

## 3.3 Widget layout yang sering digunakan

| Widget | Fungsi |
|---|---|
| `Scaffold` | Kerangka screen: app bar, body, drawer, bottom bar, FAB |
| `SafeArea` | Menghindari area status bar, notch, dan system UI |
| `Container` | Decoration, ukuran, margin, dan padding |
| `Padding` | Memberi ruang di dalam batas widget |
| `SizedBox` | Memberi jarak atau ukuran tertentu |
| `Center` / `Align` | Mengatur posisi child |
| `Row` | Menyusun child horizontal |
| `Column` | Menyusun child vertikal |
| `Expanded` | Mengisi sisa ruang pada `Row`/`Column` |
| `Flexible` | Memberi ruang fleksibel tanpa selalu memaksa mengisi sisa ruang |
| `Stack` | Menumpuk widget |
| `ListView.builder` | Membuat daftar panjang/dinamis secara efisien |
| `GridView.builder` | Membuat grid dinamis |
| `SingleChildScrollView` | Membuat satu child dapat di-scroll |
| `LayoutBuilder` | Mengatur layout berdasarkan batas ruang yang tersedia |

Perbedaan `child` dan `children`:

| Properti | Isi | Contoh |
|---|---|---|
| `child` | Satu widget | `Center`, `Padding`, `Container` |
| `children` | List widget | `Row`, `Column`, `Stack` |

Contoh layout:

```dart
Scaffold(
  appBar: AppBar(title: const Text('Dashboard')),
  body: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Ringkasan'),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => ListTile(
                title: Text('Item ${index + 1}'),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
```

**Penting:** `ListView` di dalam `Column` biasanya perlu batas tinggi. Gunakan `Expanded`, `Flexible`, atau constraint yang sesuai. Tanpa batas ukuran, layout dapat mengalami overflow atau error unbounded height.

## 3.4 List, grid, dan cards

```dart
final products = ['Laptop', 'Mouse', 'Keyboard'];

ListView.builder(
  itemCount: products.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(products[index]),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Buka detail produk.
      },
    );
  },
);
```

Contoh grid:

```dart
GridView.builder(
  itemCount: products.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
  ),
  itemBuilder: (context, index) {
    return Card(
      child: Center(child: Text(products[index])),
    );
  },
);
```

## 3.5 Input dan tombol

- `TextField`: input teks biasa.
- `TextFormField`: input yang mendukung validasi di dalam `Form`.
- `TextEditingController`: membaca, mengubah, atau mengosongkan teks input.
- `ElevatedButton`: aksi utama.
- `OutlinedButton`: aksi sekunder dengan border.
- `TextButton`: aksi ringan.
- `IconButton`: aksi berbentuk ikon.

Jika membuat `TextEditingController` di `StatefulWidget`, panggil `dispose()` saat widget tidak digunakan lagi.

```dart
final nameController = TextEditingController();

@override
void dispose() {
  nameController.dispose();
  super.dispose();
}
```

## 3.6 Responsive UI

Jangan mengasumsikan semua ponsel memiliki lebar atau tinggi yang sama.

- Gunakan `Expanded` dan `Flexible` untuk pembagian ruang.
- Gunakan `LayoutBuilder` saat layout perlu berubah berdasarkan lebar yang tersedia.
- Gunakan `MediaQuery` untuk informasi ukuran layar, text scaling, dan system insets.
- Hindari terlalu banyak ukuran tetap yang membuat UI pecah pada perangkat kecil.
- Uji portrait, landscape, ukuran teks besar, dan keyboard terbuka.

## 3.7 Assets dan gambar

Struktur sederhana:

```text
project/
├── assets/
│   └── images/
│       ├── logo.png
│       └── banner.jpg
├── lib/
└── pubspec.yaml
```

Daftarkan asset pada bagian `flutter:` di `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

Gunakan gambar lokal:

```dart
Image.asset(
  'assets/images/logo.png',
  width: 120,
  height: 120,
  fit: BoxFit.contain,
)
```

Gunakan gambar dari URL:

```dart
Image.network(
  'https://example.com/image.jpg',
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.broken_image);
  },
)
```

Setelah mengubah `pubspec.yaml`, jalankan `flutter pub get`. Pastikan path dan huruf besar-kecil nama file sesuai.

---

# 4. Navigation dan routing

Navigation mengatur perpindahan screen. Secara konsep, navigation stack menggunakan prinsip **LIFO** (*Last In, First Out*): route terakhir yang masuk akan menjadi route pertama yang dikeluarkan.

## 4.1 Navigator bawaan Flutter

| Method | Efek | Contoh |
|---|---|---|
| `push` | Menambah route | Home → Detail |
| `pop` | Menghapus route teratas | Detail → Home |
| `pushReplacement` | Mengganti route teratas | Login → Home |
| `pushAndRemoveUntil` | Menghapus route sesuai kondisi | Logout → Login |

Kirim data lewat constructor:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DetailPage(productId: 10),
  ),
);

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Text('Product ID: $productId'),
    );
  }
}
```

## 4.2 Bottom navigation dan tab

Bottom navigation dipakai untuk berpindah di antara **tujuan utama aplikasi**. Contohnya Home, Tasks, Finance, dan Profile. Untuk Flutter Material 3, gunakan `NavigationBar`; `BottomNavigationBar` adalah widget lama yang masih sering ditemukan pada tutorial Material 2.

Bedakan tiga pola ini:

| Komponen | Kapan dipakai | Perilaku |
|---|---|---|
| `NavigationBar` | Navigasi utama aplikasi | Mengganti tujuan utama |
| `TabBar` + `TabBarView` | Kategori di dalam satu tujuan | Mengganti tab pada area yang sama |
| `NavigationRail` | Navigasi pada layar lebar/tablet | Navigasi samping |

### Cara kerjanya

1. Simpan index tujuan yang sedang aktif, misalnya `0` untuk Home.
2. Saat pengguna memilih destination, ubah index.
3. Gunakan index itu untuk memilih konten.
4. Pastikan daftar destination dan daftar halaman memiliki jumlah dan urutan yang sama.

### Contoh GetX + Material 3 `NavigationBar`

Controller menyimpan index yang aktif:

```dart
import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  final selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
```

Binding mendaftarkan controller untuk route ini:

```dart
class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavigationController>(
      () => MainNavigationController(),
    );
  }
}
```

Buat halaman tujuan utama. Contoh ini memakai `IndexedStack` agar state widget pada tab yang tidak sedang terlihat tetap dipertahankan:

```dart
class MainNavigationPage extends GetView<MainNavigationController> {
  const MainNavigationPage({super.key});

  static const pages = <Widget>[
    HomePage(),
    TasksPage(),
    FinancePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: controller.changeTab,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.checklist_outlined),
              selectedIcon: Icon(Icons.checklist),
              label: 'Tasks',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: Icon(Icons.account_balance_wallet),
              label: 'Finance',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
```

Daftarkan route:

```dart
GetPage(
  name: '/main',
  page: () => const MainNavigationPage(),
  binding: MainNavigationBinding(),
),
```

**Kenapa `IndexedStack`?** Jika hanya memakai `body: pages[selectedIndex]`, Flutter dapat membuang subtree tab yang lama ketika berpindah. `IndexedStack` mempertahankan child yang tidak aktif sehingga state lokal seperti scroll position dapat tetap ada. Konsekuensinya, semua halaman di dalam stack tetap berada di memori. Untuk halaman yang sangat berat, pertimbangkan pola lazy loading.

### Hal penting saat membuat bottom navigation

- Gunakan 3–5 tujuan utama yang benar-benar sering dipakai. Jangan jadikan setiap fitur sebagai item bottom bar.
- Gunakan label yang jelas dan ikon yang konsisten.
- Jangan membuat route baru setiap kali pengguna menekan tab. Ubah selected index untuk navigasi utama.
- Tombol Back Android harus memiliki perilaku yang masuk akal. Umumnya kembali ke tab awal atau menutup halaman detail terlebih dahulu.
- Jika setiap tab perlu memiliki navigation stack sendiri, gunakan nested `Navigator` per tab. Itu pola intermediate; jangan menambah kompleksitas ini sebelum benar-benar dibutuhkan.
- Jika sebuah tab membuka halaman detail, detail biasanya masuk ke navigation stack di atas halaman utama; bottom bar dapat disembunyikan pada detail screen sesuai kebutuhan UX.

### Bottom navigation vs tab

- `NavigationBar`: berpindah antar tujuan utama aplikasi.
- `TabBar` + `TabBarView`: berpindah kategori atau subbagian di dalam satu tujuan.
- Jangan memakai keduanya untuk mengulang navigasi yang sama pada satu level.


---

# 5. State management dengan GetX

GetX (`get` di pub.dev) menyediakan tiga fitur utama:

1. **State management:** memberi tahu UI saat data berubah.
2. **Dependency injection (DI):** membuat, mendaftarkan, dan mengambil service/controller.
3. **Route management:** mengelola perpindahan halaman.

GetX bukan database, bukan API client, dan bukan pengganti arsitektur aplikasi. Gunakan GetX untuk mengelola state presentation dan dependency. Letakkan aturan bisnis dan akses data di repository/service.

## 5.1 Instalasi dan root app

```bash
flutter pub add get
```

Gunakan `GetMaterialApp` bila project memakai routing atau API GetX yang bergantung pada navigator, seperti `Get.toNamed`, snackbar, dialog, dan bottom sheet.

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/main',
      getPages: [
        GetPage(name: '/main', page: () => const MainNavigationPage()),
        GetPage(name: '/task-detail', page: () => const TaskDetailPage()),
      ],
    ),
  );
}
```

Jika hanya menggunakan reactive state atau dependency injection, `MaterialApp` biasa masih dapat dipakai. `GetMaterialApp` bukan syarat untuk `.obs` dan `Obx` saja.

## 5.2 Pahami tiga komponen: View, Controller, dan Service

```text
View (Widget)
  └── menampilkan data dan menerima input
        │ memanggil method controller
        ▼
Controller (GetxController)
  └── mengatur state layar dan alur aksi
        │ memanggil repository/service
        ▼
Repository / Service
  └── mengakses API, Hive, SharedPreferences, GPS, dan fitur lain
```

Contoh batas tanggung jawab:

- `TasksPage`: menampilkan list dan tombol tambah.
- `TasksController`: menyimpan `isLoading`, `tasks`, dan method `loadTasks()`.
- `TaskRepository`: mengambil dan menyimpan task.
- `TaskLocalDataSource`: membaca/menulis Hive.

Jangan menaruh semua kode API, database, validasi bisnis, dan UI di satu controller.

## 5.3 Reactive state: `.obs` dan `Obx`

Tambahkan `.obs` untuk membuat nilai observable. Bungkus hanya widget yang perlu berubah dengan `Obx`.

```dart
class CounterController extends GetxController {
  final count = 0.obs;

  void increment() {
    count.value++;
  }
}
```

```dart
class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CounterController>(() => CounterController());
  }
}

class CounterPage extends GetView<CounterController> {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text('Count: ${controller.count.value}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

Jenis observable yang sering digunakan:

```dart
final isLoading = false.obs;             // RxBool
final username = ''.obs;                 // RxString
final total = 0.0.obs;                   // RxDouble
final tasks = <Task>[].obs;              // RxList<Task>
final selectedTask = Rxn<Task>();       // nullable Task
```

Contoh operasi list:

```dart
tasks.add(newTask);
tasks.removeWhere((task) => task.id == id);
tasks.assignAll(tasksFromDatabase);
```

Jika mengubah properti internal object biasa yang berada di dalam `RxList`, perubahan itu belum tentu memicu rebuild. Cara sederhana: ganti object pada index yang sesuai atau panggil mekanisme refresh dengan sengaja. Lebih baik gunakan model immutable dan buat object baru saat data berubah.

## 5.4 `Obx` vs `GetBuilder`

| Pola | Cara update | Cocok untuk |
|---|---|---|
| `Obx` | Otomatis saat Rx berubah | Loading, selected tab, counter, reactive list |
| `GetBuilder` | Controller memanggil `update()` | State yang jarang berubah dan ingin dikontrol manual |

Contoh `GetBuilder`:

```dart
class SimpleCounterController extends GetxController {
  int count = 0;

  void increment() {
    count++;
    update();
  }
}
```

```dart
GetBuilder<SimpleCounterController>(
  builder: (controller) => Text('${controller.count}'),
)
```

Jangan mencampur dua pola tanpa alasan. Pilih berdasarkan pola perubahan state yang paling mudah dipahami.

## 5.5 Dependency injection: `Get.put`, `Get.lazyPut`, `Get.find`

| Method | Fungsi | Kapan digunakan |
|---|---|---|
| `Get.put(Service())` | Membuat dan mendaftarkan instance sekarang | Dependency kecil yang langsung dibutuhkan |
| `Get.lazyPut(() => Controller())` | Mendaftarkan factory; membuat instance saat pertama diakses | Controller khusus route |
| `Get.putAsync(() async => Service().init())` | Mendaftarkan dependency yang perlu inisialisasi async | Membuka database atau membaca konfigurasi |
| `Get.find<Service>()` | Mengambil dependency yang sudah terdaftar | Memakai service/controller dari tempat lain |

**Hindari `Get.put()` di dalam `build()`** untuk dependency yang seharusnya hanya dibuat sekali. Gunakan `Bindings` untuk dependency route dan bootstrap untuk service aplikasi.

## 5.6 Bindings per halaman

Binding menjadi tempat untuk menyatakan dependency yang diperlukan sebuah route.

```dart
class TasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TasksController>(
      () => TasksController(Get.find<TaskRepository>()),
    );
  }
}
```

Daftarkan Binding pada route:

```dart
GetPage(
  name: '/tasks',
  page: () => const TasksPage(),
  binding: TasksBinding(),
),
```

`GetView<TasksController>` menyediakan akses ke controller melalui `controller`. Alternatifnya, ambil dengan `Get.find<TasksController>()` setelah Binding route aktif.

## 5.7 Lifecycle controller

Method lifecycle yang umum:

| Method | Waktu dipanggil | Gunakan untuk |
|---|---|---|
| `onInit()` | Saat controller diinisialisasi | Menyiapkan state dan memulai load awal |
| `onReady()` | Setelah frame pertama selesai | Aksi yang perlu menunggu UI tampil, misalnya dialog awal |
| `onClose()` | Saat controller dilepas | Menutup controller input, stream, timer, subscription, worker |

Contoh:

```dart
class SearchController extends GetxController {
  final queryController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Persiapan awal controller.
  }

  @override
  void onClose() {
    queryController.dispose();
    super.onClose();
  }
}
```

Jangan memanggil `dispose()` pada `GetxController`. `dispose()` adalah lifecycle widget State; untuk controller GetX gunakan `onClose()` dan tutup resource yang dibuat controller.

## 5.8 `GetxService` untuk service aplikasi

`GetxService` cocok untuk service yang harus tetap tersedia selama aplikasi hidup, misalnya `ApiService`, `PreferencesService`, atau `AuthService`. Berbeda dari controller halaman, instance service biasanya tidak boleh hilang hanya karena pengguna berpindah route.

```dart
class AppConfigService extends GetxService {
  Future<AppConfigService> init() async {
    // Baca konfigurasi atau siapkan dependency.
    return this;
  }
}
```

Inisialisasi sebelum `runApp`:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync<AppConfigService>(
    () => AppConfigService().init(),
  );

  runApp(const MyApp());
}
```

Gunakan `GetxService` hanya untuk kebutuhan aplikasi lintas fitur. Jangan menjadikan semua controller sebagai service permanen.

## 5.9 Routing dan argumen

```dart
Get.toNamed('/task-detail', arguments: {'taskId': 'task-001'});
Get.back();
Get.offNamed('/main');
Get.offAllNamed('/login');
```

Ambil argumen:

```dart
final args = Get.arguments as Map<String, dynamic>;
final taskId = args['taskId'] as String;
```

Arti method:

- `Get.toNamed`: membuka route baru; route sebelumnya masih ada.
- `Get.back`: kembali satu route.
- `Get.offNamed`: mengganti route saat ini.
- `Get.offAllNamed`: menghapus stack route lama dan membuka route baru, umum untuk logout.

Untuk data penting dengan tipe yang jelas, constructor parameter juga sering lebih aman daripada `Get.arguments` karena tipe datanya terlihat langsung.

## 5.10 Checklist GetX

- [ ] Satu controller menangani satu area/fungsi yang jelas.
- [ ] View hanya menangani layout dan interaksi dasar.
- [ ] API dan database berada di service/repository.
- [ ] UI reactive hanya pada bagian yang membutuhkan update.
- [ ] Controller per halaman didaftarkan lewat Binding.
- [ ] Resource ditutup di `onClose()`.
- [ ] Service global tidak dibuat berkali-kali.
- [ ] Logout menghapus auth state dan token, lalu membersihkan route stack.


---

# 6. Form dan validasi input

Validasi input memastikan data yang dikirim sesuai aturan aplikasi. Validasi di frontend membantu UX, tetapi backend tetap harus memvalidasi ulang.

```dart
final formKey = GlobalKey<FormState>();
final emailController = TextEditingController();

Form(
  key: formKey,
  child: Column(
    children: [
      TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: 'Email'),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Email wajib diisi';
          }
          if (!value.contains('@')) {
            return 'Format email tidak valid';
          }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // Lanjutkan submit.
          }
        },
        child: const Text('Submit'),
      ),
    ],
  ),
)
```

Hal yang perlu diperhatikan:

- Gunakan `trim()` untuk menghapus spasi di awal/akhir teks.
- Gunakan input type yang sesuai, seperti email atau number.
- Tampilkan pesan error dekat input yang bermasalah.
- Nonaktifkan tombol submit saat request sedang berjalan agar tidak terkirim berkali-kali.
- Selalu validasi ulang pada backend.

---

# 7. HTTP request dan REST API

Aplikasi biasanya meminta atau mengirim data melalui HTTP. Server menyediakan endpoint, lalu aplikasi membaca response dan mengubahnya menjadi model.

## 7.1 Istilah yang perlu dipahami

| Istilah | Arti |
|---|---|
| Endpoint | Alamat resource API, misalnya `/users` |
| Request | Pesan dari aplikasi ke server |
| Response | Jawaban server |
| Header | Metadata request/response, misalnya `Authorization` |
| Body | Isi data yang dikirim, sering berupa JSON |
| Status code | Kode hasil request |
| Base URL | Alamat dasar server API |
| Bearer token | Token yang dikirim melalui header Authorization |

Method HTTP yang umum:

| Method | Tujuan umum |
|---|---|
| `GET` | Membaca data |
| `POST` | Membuat data atau menjalankan aksi |
| `PUT` | Mengganti resource |
| `PATCH` | Memperbarui sebagian resource |
| `DELETE` | Menghapus resource |

Status code yang sering ditemui:

| Status | Makna |
|---|---|
| `200` | Request berhasil |
| `201` | Resource berhasil dibuat |
| `204` | Berhasil tanpa response body |
| `400` | Request tidak valid |
| `401` | Belum terautentikasi / token tidak valid |
| `403` | Tidak memiliki izin |
| `404` | Resource tidak ditemukan |
| `422` | Data gagal divalidasi oleh server |
| `500` | Kesalahan server |

## 7.2 HTTP request dengan package `http`

```bash
flutter pub add http
```

Contoh model:

```dart
class Post {
  const Post({required this.id, required this.title});

  final int id;
  final String title;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}
```

Contoh GET:

```dart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final uri = Uri.https('jsonplaceholder.typicode.com', '/posts/1');

  try {
    final response = await http.get(uri).timeout(
      const Duration(seconds: 15),
    );

    if (response.statusCode != 200) {
      throw Exception('Request gagal: HTTP ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return Post.fromJson(json);
  } on TimeoutException {
    throw Exception('Request timeout. Periksa koneksi lalu coba lagi.');
  } on http.ClientException {
    throw Exception('Tidak dapat terhubung ke server.');
  }
}
```

Contoh POST JSON:

```dart
final response = await http.post(
  Uri.https('example.com', '/api/tasks'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'title': 'Belajar Flutter',
    'isDone': false,
  }),
);
```

Contoh API di atas menggunakan host ilustratif. Ganti dengan base URL backend milik project.

## 7.3 GetX controller untuk request API

```dart
class PostController extends GetxController {
  final posts = <Post>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> loadPost() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final post = await fetchPost();
      posts.assignAll([post]);
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
```

UI minimalnya harus dapat membedakan empat keadaan: **loading**, **success berisi data**, **success tetapi kosong**, dan **error**.

## 7.4 `http` atau `Dio`?

| Pilih `http` jika... | Pilih `Dio` jika... |
|---|---|
| Ingin memahami HTTP dari dasar | Aplikasi memiliki banyak endpoint |
| Request sederhana | Butuh interceptor untuk token |
| Ingin dependency yang sederhana | Butuh upload/download file dan progress |
| Belum membutuhkan konfigurasi kompleks | Butuh cancel request dan konfigurasi global |

Untuk belajar, mulai dari `http`. Setelah mengerti request-response, pelajari Dio. Jangan menggunakan dua client sekaligus tanpa alasan yang jelas.

## 7.5 Aturan networking

- Jangan mengirim request langsung dari `build()` karena rebuild dapat membuat request berulang.
- Tangani timeout, koneksi gagal, status code non-2xx, dan response JSON yang tidak sesuai.
- Jangan menganggap semua response selalu memiliki body JSON.
- Simpan base URL di konfigurasi environment, bukan tersebar di banyak file.
- Jangan menanam password server atau secret privat di aplikasi mobile. Aplikasi client dapat dianalisis.
- Jangan mencetak access token, password, atau data pribadi ke log.
- Gunakan repository agar UI tidak bergantung langsung pada detail HTTP.

---

# 8. Local storage

**Local storage** adalah tempat aplikasi menyimpan data di perangkat pengguna. Data yang persisten tetap tersedia setelah app ditutup atau perangkat restart, sampai data dihapus, app di-uninstall, atau sistem menghapusnya sesuai mekanisme storage.

Jangan memilih storage hanya berdasarkan package yang populer. Mulai dari pertanyaan: datanya seperti apa, seberapa besar, perlu query seperti apa, dan apakah data itu sensitif?

## 8.1 Pilih storage yang tepat

| Kebutuhan | Pilihan | Contoh |
|---|---|---|
| State sementara | GetX / memory | Loading, tab aktif, filter sementara |
| Preferensi kecil | SharedPreferences | Tema, bahasa, onboarding selesai |
| Credential/token | `flutter_secure_storage` | Access token, refresh token |
| Key-value dan object lokal | Hive CE | Draft, transaksi sederhana, cache object |
| Relasi dan query kompleks | SQLite (`sqflite` / `drift`) | Transaksi, kategori, relasi user–order |
| File binary | File system + `path_provider` | Foto, PDF, export backup |

### Cara memilih dengan cepat

- Simpan `isDarkMode`, `languageCode`, atau `hasSeenIntro`? Gunakan SharedPreferences.
- Simpan `Task`, `Transaction`, atau object lokal yang dibaca berdasarkan key? Gunakan Hive CE.
- Perlu `JOIN`, foreign key, aggregate query, indexing, atau transaksi SQL? Gunakan SQLite/Drift.
- Simpan token login? Gunakan secure storage, bukan SharedPreferences atau Hive biasa.
- Simpan foto? Simpan file di folder aplikasi dan simpan path/metadata-nya di database.

**Jangan menyimpan file gambar besar sebagai base64 di SharedPreferences.** Simpan file fisiknya, lalu simpan path dan metadata.

## 8.2 SharedPreferences: preferensi kecil

`shared_preferences` menyimpan pasangan key-value sederhana. Tipe data yang didukung: `int`, `double`, `bool`, `String`, dan `List<String>`. Package ini bukan database transaksi dan tidak menjamin setiap penulisan sudah benar-benar persisten ke disk ketika method selesai. Jangan gunakan untuk data kritis.

Instalasi:

```bash
flutter pub add shared_preferences
```

### Pilih API yang tepat

Package menyediakan tiga API utama:

| API | Cara membaca | Catatan |
|---|---|---|
| `SharedPreferences` | Sync setelah `getInstance()` | API lama; untuk kode baru pilih API modern |
| `SharedPreferencesAsync` | Async (`await`) | Tidak memakai cache lokal; membaca nilai terbaru dari platform |
| `SharedPreferencesWithCache` | Sync setelah cache dibuat | Cocok bila ingin akses baca sinkron dari cache |

Untuk contoh baru, gunakan `SharedPreferencesAsync` agar alur read/write terlihat jelas:

```dart
import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<void> saveTheme(String theme) async {
    await _prefs.setString('theme_mode', theme);
  }

  Future<String> getTheme() async {
    return await _prefs.getString('theme_mode') ?? 'system';
  }

  Future<void> saveOnboardingDone(bool value) async {
    await _prefs.setBool('onboarding_done', value);
  }

  Future<bool> isOnboardingDone() async {
    return await _prefs.getBool('onboarding_done') ?? false;
  }

  Future<void> clearTheme() async {
    await _prefs.remove('theme_mode');
  }
}
```

### Gunakan dari GetX service

```dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends GetxService {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();
  final isDarkMode = false.obs;

  Future<PreferencesService> init() async {
    isDarkMode.value = await _prefs.getBool('dark_mode') ?? false;
    return this;
  }

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool('dark_mode', value);
    isDarkMode.value = value;
  }
}
```

Daftarkan sebelum `runApp`:

```dart
await Get.putAsync<PreferencesService>(
  () => PreferencesService().init(),
);
```

UI dapat membaca preferensi:

```dart
final settings = Get.find<PreferencesService>();

Obx(
  () => Switch(
    value: settings.isDarkMode.value,
    onChanged: settings.setDarkMode,
  ),
)
```

**Catatan cache:** `SharedPreferencesWithCache` dan API lama memiliki cache lokal. Jika nilai dapat diubah dari isolate, engine, atau native code lain, cache bisa tidak terbaru. `SharedPreferencesAsync` menghindari cache tersebut dengan membaca/menulis secara asynchronous.

## 8.3 Secure Storage: data sensitif

Instalasi:

```bash
flutter pub add flutter_secure_storage
```

Contoh:

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();

Future<void> saveAccessToken(String token) async {
  await secureStorage.write(key: 'access_token', value: token);
}

Future<String?> readAccessToken() async {
  return secureStorage.read(key: 'access_token');
}

Future<void> clearTokens() async {
  await secureStorage.delete(key: 'access_token');
  await secureStorage.delete(key: 'refresh_token');
}
```

Pada Android, package menggunakan mekanisme enkripsi dan penyimpanan kunci yang sesuai platform. Periksa catatan versi Android package, terutama ketika berpindah major version atau mengubah cipher. Jangan hardcode encryption key di source code dan jangan menyimpan password mentah pengguna.

Secure storage melindungi data lokal tertentu; ia tidak otomatis mengamankan seluruh API, memory, log, backup, atau perangkat yang sudah di-root.

## 8.4 Hive CE: key-value database dan object lokal

**Hive CE (Community Edition)** adalah kelanjutan komunitas dari ekosistem Hive v2. Hive menyimpan data dalam `Box`. Setiap box dapat dipahami sebagai koleksi key-value yang persisten.

Gunakan Hive ketika kamu ingin menyimpan object lokal secara praktis, misalnya daftar tugas, catatan, transaksi, atau cache response API. Hive bukan pengganti SQLite jika kamu membutuhkan SQL join, relasi kompleks, index query, atau aggregate query besar.

### A. Instalasi

```bash
flutter pub add hive_ce hive_ce_flutter
flutter pub add --dev hive_ce_generator build_runner
```

- `hive_ce`: database dan API inti.
- `hive_ce_flutter`: helper untuk Flutter, termasuk `Hive.initFlutter()`.
- `hive_ce_generator`: membuat TypeAdapter untuk class Dart.
- `build_runner`: menjalankan code generation.

### B. Inisialisasi Hive

Hive harus diinisialisasi sebelum box dibuka. Karena `initFlutter()` dan `openBox()` asynchronous, gunakan `WidgetsFlutterBinding.ensureInitialized()` dan `main()` asynchronous.

```dart
import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('settings');

  runApp(const MyApp());
}
```

Untuk box berisi object khusus, register TypeAdapter sebelum memanggil `openBox<T>()`. Contoh lengkap ada di bagian D.

### C. Box dan CRUD untuk tipe dasar

```dart
final box = Hive.box('settings');

// CREATE: membuat key baru atau mengganti value pada key yang sama.
await box.put('theme', 'dark');

// READ: null jika key tidak ada; gunakan defaultValue bila diperlukan.
final theme = box.get('theme', defaultValue: 'system');

// UPDATE: put pada key yang sudah ada akan mengganti nilainya.
await box.put('theme', 'light');

// DELETE: menghapus satu key.
await box.delete('theme');

// CLEAR: menghapus seluruh isi box, bukan menutup box.
await box.clear();
```

Hive mendukung tipe dasar seperti `int`, `double`, `bool`, `String`, `List`, `Set`, `Map`, `DateTime`, `Duration`, dan beberapa tipe binary. Untuk class buatan sendiri, gunakan TypeAdapter.

### D. Simpan model Dart dengan TypeAdapter

Misalnya aplikasi memiliki model `Task`:

```dart
class Task {
  const Task({
    required this.id,
    required this.title,
    required this.isDone,
    required this.createdAt,
  });

  final String id;
  final String title;
  final bool isDone;
  final DateTime createdAt;
}
```

Buat file `lib/hive/hive_adapters.dart`:

```dart
import 'package:hive_ce/hive_ce.dart';
import '../models/task.dart';

@GenerateAdapters([AdapterSpec<Task>()])
part 'hive_adapters.g.dart';
```

Generate adapter dan registrar:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generator membuat kode adapter dan file schema/registrar. Ikuti output generator pada versi yang terpasang. File schema `hive_adapters.g.yaml` harus disimpan dalam version control karena membantu generator menjaga kompatibilitas field antarversi aplikasi.

Register adapter sebelum membuka box bertipe `Task`:

```dart
import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'hive/hive_registrar.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox<Task>('tasks');

  runApp(const MyApp());
}
```

Pastikan import model `Task` tersedia di file tempat membuka box. `Hive.registerAdapters()` berasal dari registrar yang dibuat oleh generator.

### E. CRUD untuk object Task

```dart
final Box<Task> tasksBox = Hive.box<Task>('tasks');

// CREATE: gunakan ID stabil sebagai key.
final task = Task(
  id: 'task-001',
  title: 'Belajar Hive',
  isDone: false,
  createdAt: DateTime.now(),
);
await tasksBox.put(task.id, task);

// READ satu data.
final savedTask = tasksBox.get('task-001');

// READ semua data.
final allTasks = tasksBox.values.toList();

// UPDATE: model immutable → buat object baru, lalu timpa key lama.
if (savedTask != null) {
  final updatedTask = Task(
    id: savedTask.id,
    title: savedTask.title,
    isDone: true,
    createdAt: savedTask.createdAt,
  );
  await tasksBox.put(updatedTask.id, updatedTask);
}

// DELETE satu data.
await tasksBox.delete('task-001');
```

### F. Pisahkan akses Hive ke data source/repository

Jangan memanggil `Hive.box()` dan melakukan semua operasi database langsung di banyak widget. Bungkus operasi itu dalam satu class agar mudah diuji dan diganti.

```dart
import 'package:hive_ce/hive.dart';

class TaskLocalDataSource {
  late final Box<Task> _box;

  Future<void> init() async {
    _box = await Hive.openBox<Task>('tasks');
  }

  List<Task> getAll() => _box.values.toList();

  Task? getById(String id) => _box.get(id);

  Future<void> save(Task task) => _box.put(task.id, task);

  Future<void> delete(String id) => _box.delete(id);

  Future<void> clear() => _box.clear();
}
```

Panggil `init()` sekali pada saat bootstrap aplikasi, bukan setiap kali screen dibuat. Pada project nyata, kamu bisa membuat `TaskRepository` yang menggunakan `TaskLocalDataSource` dan juga remote API. Pastikan semua operasi tulis penting memakai `await`; jangan menutup box atau mengakhiri alur aplikasi sebelum penulisan selesai.

### F.1 Hubungkan perubahan Hive ke UI GetX

`Box.watch()` mengirim event ketika isi box berubah. Controller dapat mendengarkan stream itu, memperbarui `RxList`, lalu `Obx` menggambar ulang bagian UI yang memakai data tersebut.

```dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

class TasksController extends GetxController {
  TasksController(this._box);

  final Box<Task> _box;
  final tasks = <Task>[].obs;
  StreamSubscription<BoxEvent>? _boxSubscription;

  @override
  void onInit() {
    super.onInit();
    _syncFromBox();
    _boxSubscription = _box.watch().listen((_) => _syncFromBox());
  }

  void _syncFromBox() {
    tasks.assignAll(_box.values.toList());
  }

  Future<void> save(Task task) async {
    await _box.put(task.id, task);
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  @override
  void onClose() {
    _boxSubscription?.cancel();
    super.onClose();
  }
}
```

Contoh UI:

```dart
Obx(
  () => ListView.builder(
    itemCount: controller.tasks.length,
    itemBuilder: (context, index) {
      final task = controller.tasks[index];
      return ListTile(title: Text(task.title));
    },
  ),
)
```

Daftarkan `TasksController` melalui Binding dan berikan box yang sudah dibuka. Pola ini membuat alurnya jelas: **Hive menyimpan data → stream memberi tahu controller → RxList berubah → Obx memperbarui UI**. Batalkan subscription pada `onClose()` agar tidak ada listener yang tertinggal.

### G. Filter dan sort

Hive adalah key-value store, bukan SQL query engine. Untuk kumpulan data yang masih wajar, filter dan sort di Dart:

```dart
final completedTasks = tasksBox.values
    .where((task) => task.isDone)
    .toList();

completedTasks.sort(
  (a, b) => b.createdAt.compareTo(a.createdAt),
);
```

Untuk jutaan record atau filter kompleks yang sering dilakukan, pertimbangkan database relasional dengan index dan query yang tepat.

### H. Box biasa vs LazyBox

- `Box<T>` menyimpan value yang dibuka agar akses lebih cepat; cocok untuk kebanyakan data aplikasi berukuran wajar.
- `LazyBox<T>` membaca value ketika diminta; dapat membantu untuk value besar yang tidak perlu dimuat semuanya ke memory.

Jangan pilih `LazyBox` hanya karena namanya terdengar lebih efisien. Ukur kebutuhan dan baca dokumentasinya.

### I. Enkripsi dan migrasi data

Hive CE memiliki fitur enkripsi box, tetapi kunci enkripsi tetap harus dikelola dengan benar. Jangan hardcode key dan jangan menyimpan key di box yang sama. Simpan key menggunakan secure storage atau mekanisme key management yang sesuai.

Saat mengubah model yang sudah dipakai pengguna:

- Menambah field baru perlu default value yang sesuai agar data lama tetap dapat dibaca.
- Mengubah tipe field yang sudah tersimpan dapat memerlukan strategi migrasi.
- Rename class/field dapat memerlukan penyesuaian schema generator.
- Jangan sembarang menghapus file box pengguna saat upgrade.
- Uji upgrade aplikasi menggunakan data yang dibuat oleh versi sebelumnya.

### J. Kesalahan Hive yang umum

- Membuka box sebelum `Hive.initFlutter()`.
- Membuka `Box<Task>` sebelum adapter `Task` diregistrasi.
- Membuka box bernama berbeda antara initialization dan pemakaian.
- Menganggap `clear()` sama dengan `close()`.
- Menyimpan data sensitif tanpa enkripsi/key management.
- Menggunakan Hive untuk query relasional yang seharusnya memakai SQLite.

## 8.5 SQLite: data relasional

SQLite cocok ketika data memiliki tabel, relasi, constraint, transaksi, dan query kompleks.

```text
users
- id (primary key)
- name

transactions
- id (primary key)
- user_id (foreign key → users.id)
- amount
- category_id
- created_at
```

- `sqflite`: akses SQLite melalui SQL langsung.
- `drift`: lapisan database type-safe dengan query yang lebih terstruktur.

Gunakan SQLite ketika query menjadi inti kebutuhan aplikasi, bukan sekadar karena jumlah package lebih sedikit.


---

# 9. Session dan authentication

Session adalah kondisi autentikasi pengguna selama menggunakan aplikasi. Contohnya: apakah pengguna sudah login, siapa pengguna aktif, dan apakah sesi masih berlaku.

**Session bukan jenis database.** Session adalah konsep pengelolaan status login. Aplikasi dapat menyimpan token secara aman agar status login bisa dipulihkan saat dibuka kembali.

## 9.1 Bedakan empat hal ini

| Komponen | Tugas |
|---|---|
| Auth API | Memverifikasi credential dan memberikan token |
| Secure storage | Menyimpan token secara aman di perangkat |
| Auth controller | Menyimpan state login yang sedang aktif dan mengatur alurnya |
| Repository | Menghubungkan auth API dengan storage dan model aplikasi |

Alur login yang umum:

```text
Login screen
   │ email + password
   ▼
Auth API (POST /login)
   │ berhasil
   ▼
Server mengirim access token (+ refresh token jika digunakan)
   │
   ├── Simpan token di secure storage
   └── Update auth state di controller
           │
           ▼
       Main screen
```

Saat aplikasi dibuka kembali:

```text
App start
   │
   ▼
Baca token dari secure storage
   │
   ▼
Validasi / refresh token ke backend
   ├── Valid → pulihkan user session → Home
   └── Tidak valid → bersihkan session → Login
```

Jangan hanya memeriksa apakah string token ada. Token dapat kedaluwarsa, dicabut, atau tidak lagi diterima server.

## 9.2 Contoh AuthController sederhana

Contoh ini menunjukkan pemisahan state dan secure storage. Bagian validasi token ke backend sengaja belum diimplementasikan.

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthController(this.storage);

  final FlutterSecureStorage storage;
  final isLoggedIn = false.obs;
  final isRestoringSession = true.obs;

  @override
  void onInit() {
    super.onInit();
    restoreSession();
  }

  Future<void> restoreSession() async {
    try {
      final token = await storage.read(key: 'access_token');

      // Demo: hanya memeriksa keberadaan token.
      // Aplikasi nyata harus memvalidasi/refresh token ke backend.
      isLoggedIn.value = token != null && token.isNotEmpty;
    } catch (_) {
      isLoggedIn.value = false;
    } finally {
      isRestoringSession.value = false;
    }
  }

  Future<void> saveSession(String accessToken) async {
    await storage.write(key: 'access_token', value: accessToken);
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    await storage.delete(key: 'access_token');
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
```

Contoh UI perlu menunggu proses restore selesai sebelum menentukan screen:

```dart
Obx(() {
  if (authController.isRestoringSession.value) {
    return const SplashScreen();
  }

  if (authController.isLoggedIn.value) {
    return const HomePage();
  }

  return const LoginPage();
});
```

Di aplikasi sebenarnya, pengaturan initial route dapat dibuat melalui splash/bootstrap controller atau middleware. Jangan menampilkan halaman privat sebelum proses pemulihan session selesai.

## 9.3 Access token dan refresh token

- **Access token:** dikirim ke API untuk mengakses resource yang dilindungi; biasanya masa berlakunya lebih pendek.
- **Refresh token:** digunakan untuk memperoleh access token baru, jika backend mendukung mekanisme tersebut.
- **401 Unauthorized:** token tidak valid atau sesi tidak diterima; jalankan refresh flow jika tersedia, jika gagal minta pengguna login kembali.
- **Logout:** hapus token lokal, bersihkan state pengguna, dan hapus cache privat yang sesuai.

Jangan menganggap semua backend memakai pola token yang sama. Ikuti kontrak API backend.

---

# 10. Local notification (Android-first)

**Local notification** adalah notifikasi yang dibuat dan dijadwalkan oleh aplikasi di perangkat. Contoh: pengingat deadline, tagihan, jadwal kuliah, atau rutinitas.

Bedakan dari push notification:

| Local notification | Push notification |
|---|---|
| Dibuat/dijadwalkan di perangkat | Dikirim dari server melalui layanan push seperti Firebase Cloud Messaging |
| Dapat dijadwalkan tanpa koneksi server setelah data jadwal tersedia | Umumnya butuh backend dan layanan push |
| Contoh: ingatkan deadline pukul 19.00 | Contoh: pesan baru masuk dari pengguna lain |

## 10.1 Package dan konsep inti

```bash
flutter pub add flutter_local_notifications timezone flutter_timezone
```

Istilah yang perlu dipahami:

- **Initialize:** membuat instance plugin dan mendaftarkan callback.
- **Permission:** izin sistem untuk menampilkan notifikasi.
- **Notification channel (Android 8+):** kategori yang mengatur perilaku notifikasi seperti suara dan importance.
- **Notification ID:** identitas notifikasi; ID sama akan memperbarui/menimpa notifikasi dengan ID tersebut.
- **Payload:** data kecil seperti `taskId` yang dipakai ketika pengguna mengetuk notifikasi.
- **Schedule:** menjadwalkan notifikasi untuk waktu tertentu.
- **Cancel:** membatalkan notifikasi berdasarkan ID.
- **Timezone:** zona waktu lokal yang menentukan interpretasi jam pada jadwal.

## 10.2 Perilaku Android yang wajib diketahui

| Android | Dampak untuk developer |
|---|---|
| Android 8.0+ (API 26) | Notifikasi harus masuk ke notification channel. Pengguna mengontrol channel dari Settings. |
| Android 13+ (API 33) | App perlu meminta runtime permission `POST_NOTIFICATIONS` sebelum menampilkan notifikasi non-exempt. |
| Android 12+ (API 31) | Exact alarm memerlukan akses khusus sesuai jenis permission dan use case. |
| Android 14+ (API 34) | Akses `SCHEDULE_EXACT_ALARM` tidak otomatis diberikan untuk fresh install yang relevan; cek izin sebelum menjadwalkan exact alarm. |

### Notification channel

Buat channel berdasarkan jenis pesan, misalnya:

- `task_reminders`: pengingat tugas.
- `bill_reminders`: pengingat tagihan.
- `general_updates`: informasi umum.

Channel ID harus stabil. Setelah channel dibuat, pengguna dapat mengubah perilakunya dari Android Settings. Aplikasi tidak dapat memaksa mengubah kembali importance/sound channel yang sudah dibuat; jika perilaku baru benar-benar diperlukan, buat channel ID baru dengan alasan UX yang jelas.

## 10.3 Setup Android native

### A. Gradle Kotlin DSL

Pada versi terbaru `flutter_local_notifications` yang didokumentasikan saat panduan ini diperbarui, plugin membutuhkan `compileSdk` minimal 37 dan core library desugaring. Konfigurasi Gradle bergantung versi plugin dan Android Gradle Plugin project.

Contoh pola untuk `android/app/build.gradle.kts`:

```kotlin
android {
    compileSdk = 37

    defaultConfig {
        multiDexEnabled = true
    }

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
```

Jika project mempunyai source Kotlin, ikuti contoh `kotlin { compilerOptions { ... } }` pada dokumentasi plugin dan sesuaikan dengan versi AGP. Dokumentasi versi terbaru plugin menyebut AGP 9.1.1 sebagai versi yang disarankan untuk setup tersebut.

> **Jangan menyalin konfigurasi di atas secara membabi buta.** Jika Gradle Wrapper, AGP, Kotlin, atau Flutter project kamu lebih lama, versi plugin terbaru mungkin tidak kompatibel. Cocokkan semua versi menggunakan dokumentasi resmi dan pilih versi plugin yang mendukung toolchain project. Jangan menaikkan satu versi Gradle tanpa memeriksa kompatibilitas lainnya.

### B. AndroidManifest untuk scheduled notification

File: `android/app/src/main/AndroidManifest.xml`.

Untuk penjadwalan yang perlu dipulihkan setelah perangkat reboot, tambahkan permission ini sebagai child dari `<manifest>`:

```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
```

Untuk exact alarm, tambahkan permission ini hanya jika fitur produk benar-benar membutuhkan waktu yang presisi dan kamu sudah menyiapkan alur izin khusus:

```xml
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
```

Di dalam `<application>`, tambahkan receiver yang dibutuhkan plugin untuk scheduled notifications:

```xml
<receiver
    android:exported="false"
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />

<receiver
    android:exported="false"
    android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED" />
        <action android:name="android.intent.action.MY_PACKAGE_REPLACED" />
        <action android:name="android.intent.action.QUICKBOOT_POWERON" />
        <action android:name="com.htc.intent.action.QUICKBOOT_POWERON" />
    </intent-filter>
</receiver>
```

Jangan menyalin semua permission dari sample app plugin. Tambahkan hanya fitur yang memang digunakan.

## 10.4 Inisialisasi dan permission

Buat satu service agar seluruh fitur memakai instance plugin yang sama.

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('ic_stat_notification'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        // Saat app aktif, gunakan payload untuk membuka detail yang sesuai.
        // Pastikan route GetX sudah siap sebelum melakukan navigasi.
        if (payload != null) {
          // Contoh: Get.toNamed('/task-detail', arguments: payload);
        }
      },
    );
  }

  Future<bool> requestAndroidPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (android == null) return false;

    final granted = await android.requestNotificationsPermission();
    return granted ?? false;
  }

  Future<void> showTestNotification() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'general_updates',
        'General updates',
        channelDescription: 'Informasi umum dari aplikasi',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
    );

    await _plugin.show(
      id: 1,
      title: 'Pengingat',
      body: 'Notifikasi lokal berhasil ditampilkan.',
      notificationDetails: details,
      payload: 'test-item',
    );
  }
}
```

Panggil `initialize()` satu kali saat bootstrap aplikasi. Jangan membuat service baru setiap kali screen dibuka.

Pada Android 13+, minta permission notifikasi pada konteks yang masuk akal, misalnya setelah pengguna mengaktifkan fitur reminder. Jangan langsung menampilkan dialog izin saat app pertama kali dibuka tanpa penjelasan. Jika permission ditolak, fitur lain tetap harus dapat digunakan.

## 10.5 Ikon dan channel Android

Buat small notification icon khusus di folder resource Android, misalnya:

```text
android/app/src/main/res/drawable/ic_stat_notification.xml
```

Ikuti aturan ikon notifikasi Android: bentuk sederhana, biasanya putih dengan background transparan. Jangan mengandalkan launcher icon berwarna penuh untuk small icon.

Penting:

- Android 8+ mewajibkan channel.
- Sound, vibration, dan importance ditautkan ke channel.
- Jika channel ID yang sama sudah dibuat, perubahan di kode tidak otomatis mengubah setting yang telah dipilih pengguna.
- Uji channel melalui Android Settings > Apps > nama aplikasi > Notifications.

## 10.6 Schedule dengan timezone lokal

Jangan menjadwalkan alarm kalender hanya dengan menambahkan durasi ke UTC tanpa memahami timezone. Gunakan `timezone` untuk `TZDateTime`, dan `flutter_timezone` untuk membaca timezone perangkat.

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> initializeLocalTimezone() async {
  tz.initializeTimeZones();

  final deviceTimezone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(deviceTimezone.identifier));
}
```

Contoh menjadwalkan notifikasi lima menit dari sekarang (setelah timezone dan plugin sudah diinisialisasi):

```dart
Future<void> scheduleReminder(
  FlutterLocalNotificationsPlugin plugin,
) async {
  await plugin.zonedSchedule(
    id: 1001,
    title: 'Deadline mendekat',
    body: 'Periksa tugas yang harus diselesaikan.',
    scheduledDate: tz.TZDateTime.now(tz.local).add(
      const Duration(minutes: 5),
    ),
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails(
        'task_reminders',
        'Task reminders',
        channelDescription: 'Pengingat tugas dan deadline',
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    payload: 'task-001',
  );
}
```

`inexactAllowWhileIdle` mengizinkan sistem mengatur waktu tampil dalam rentang yang wajar dan umumnya lebih ramah baterai. Pilih exact alarm hanya bila waktu yang sangat presisi benar-benar bagian dari fungsi utama aplikasi. Jika memakai exact alarm, periksa `canScheduleExactAlarms()` dan minta akses khusus melalui API plugin bila diperlukan. Jangan menganggap permission exact alarm sama dengan permission notifikasi.

## 10.7 Cancel, pending notification, dan tap action

```dart
await plugin.cancel(1001); // Batalkan satu notifikasi.
await plugin.cancelAll();  // Batalkan semua notifikasi aplikasi.

final pending = await plugin.pendingNotificationRequests();
```

Praktik yang baik:

- Gunakan ID yang stabil untuk reminder dari satu task, supaya update task bisa menjadwalkan ulang reminder dengan ID yang sama.
- Saat task dihapus atau selesai, batalkan notifikasinya.
- Simpan relasi antara ID reminder dan ID task di storage bila perlu membatalkan/memperbarui jadwal setelah app restart.
- Payload cukup berisi ID atau route key, bukan seluruh object besar.
- Jika notifikasi membuka app dari kondisi terminated, periksa `getNotificationAppLaunchDetails()` ketika startup. Callback `onDidReceiveNotificationResponse` bukan satu-satunya jalur untuk cold start.

## 10.8 Uji di Android nyata

Uji kasus berikut, bukan hanya menekan tombol saat app sedang terbuka:

- [ ] Permission notifikasi granted.
- [ ] Permission notifikasi denied.
- [ ] Notifikasi tampil saat app foreground.
- [ ] Notifikasi tampil saat app background.
- [ ] Pengguna menekan notifikasi dan masuk ke detail yang benar.
- [ ] Notifikasi terjadwal tetap benar setelah perangkat reboot.
- [ ] Jadwal tetap benar setelah timezone berubah.
- [ ] Task dihapus/selesai lalu reminder dibatalkan.
- [ ] Exact alarm tidak diizinkan; app tetap menangani fallback.

### Troubleshooting Android

- **Notifikasi tidak tampil:** cek runtime permission, channel, app notification settings, manifest, dan ID.
- **Tidak muncul heads-up:** `Importance.high`/`Priority.high` membantu, tetapi pengguna dan sistem tetap mengontrol gangguan notifikasi.
- **Jadwal hilang setelah reboot:** periksa permission `RECEIVE_BOOT_COMPLETED` dan receiver.
- **Exact schedule melempar error:** cek akses exact alarm dan fallback ke inexact schedule. `USE_EXACT_ALARM` memiliki batasan use case dan kebijakan distribusi; jangan memilihnya hanya agar alarm selalu tepat waktu.
- **Jadwal terlambat pada ponsel tertentu:** beberapa vendor Android membatasi proses latar belakang. Uji di perangkat target dan jelaskan pengaturan battery/background kepada pengguna hanya bila memang diperlukan.
- **Build gagal setelah upgrade package:** periksa `compileSdk`, AGP, Gradle Wrapper, Java, desugaring, serta versi Flutter.


---

# 11. LBS (Location-Based Services)

**Location-Based Services (LBS)** adalah fitur aplikasi yang memakai posisi geografis perangkat untuk memberikan layanan berdasarkan lokasi. Contoh: menampilkan posisi pengguna, menemukan tempat terdekat, check-in, atau menghitung jarak.

LBS bukan hanya Google Maps. Aplikasi dapat memakai koordinat tanpa menampilkan peta.

## 11.1 Komponen LBS

| Komponen | Fungsi | Contoh package/API |
|---|---|---|
| Device location | Mendapatkan latitude/longitude dari sistem lokasi Android | `geolocator` |
| Geocoding | Mengubah alamat menjadi koordinat atau koordinat menjadi alamat | `geocoding` |
| Map display | Menampilkan peta dan marker | `google_maps_flutter` |
| Places/search | Mencari bisnis atau titik penting | Places API/penyedia data tempat |
| Routing/directions | Menghitung rute jalan, bukan garis lurus | Directions/Routing API |

Contoh koordinat:

```text
latitude  = -7.7956
longitude = 110.3695
```

- Latitude: posisi utara/selatan dari garis khatulistiwa.
- Longitude: posisi timur/barat dari garis meridian utama.
- `accuracy`: perkiraan radius ketidakpastian lokasi, biasanya dalam meter.

## 11.2 Instalasi dan AndroidManifest

```bash
flutter pub add geolocator
```

Tambahkan permission yang dibutuhkan di `android/app/src/main/AndroidManifest.xml`, sebagai child dari `<manifest>` dan di luar `<application>`:

```xml
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

- `ACCESS_COARSE_LOCATION`: approximate location; cukup untuk banyak fitur berbasis kota/area.
- `ACCESS_FINE_LOCATION`: precise location; minta hanya bila fitur benar-benar membutuhkan presisi lebih tinggi.

Pada Android 12+, pengguna dapat memilih approximate location meskipun aplikasi meminta precise location. Karena itu, deklarasikan dan minta coarse + fine secara bersama jika fitur membutuhkan opsi precise. Jangan berasumsi pengguna selalu memberikan fine location.

Jika aplikasi hanya perlu lokasi saat pengguna membuka screen, **jangan tambahkan background location permission**.

## 11.3 Alur mendapatkan lokasi satu kali

Sebelum mengambil lokasi, aplikasi harus memeriksa dua hal berbeda:

1. Apakah Location Services (GPS/network location) aktif di perangkat?
2. Apakah aplikasi memiliki permission lokasi?

Contoh helper:

```dart
import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentDeviceLocation() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    throw Exception('Aktifkan Location Services terlebih dahulu.');
  }

  var permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.denied) {
    throw Exception('Izin lokasi ditolak.');
  }

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openAppSettings();
    throw Exception('Izin lokasi diblokir. Ubah izin dari App Settings.');
  }

  return Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 20),
    ),
  );
}
```

Pemakaian:

```dart
final position = await getCurrentDeviceLocation();

print('Latitude: ${position.latitude}');
print('Longitude: ${position.longitude}');
print('Accuracy: ${position.accuracy} meters');
```

Jangan menjalankan helper ini langsung dalam `build()`. Panggil dari aksi pengguna atau controller, tampilkan loading, dan tangani error dengan pesan yang dapat dipahami.

### Memahami permission state

| Status | Makna | Tindakan aplikasi |
|---|---|---|
| `denied` | Pengguna belum memberi izin atau menolak sementara | Jelaskan alasan, boleh meminta lagi sesuai konteks |
| `deniedForever` | Izin diblokir; dialog normal tidak akan muncul lagi | Tawarkan tombol ke App Settings |
| `whileInUse` | Lokasi boleh dipakai saat app digunakan | Cukup untuk banyak fitur foreground |
| `always` | Akses background tersedia pada platform yang mendukung | Pakai hanya jika fitur inti memang membutuhkan lokasi background |

Jangan menganggap permission granted berarti GPS pasti aktif. Jangan pula menganggap GPS aktif berarti aplikasi otomatis mendapat izin.

## 11.4 Last known location vs current location

```dart
final lastPosition = await Geolocator.getLastKnownPosition();
```

- `getLastKnownPosition()`: dapat lebih cepat karena memakai posisi terakhir yang diketahui sistem; hasilnya bisa `null` atau sudah lama.
- `getCurrentPosition()`: meminta posisi yang lebih baru; dapat memerlukan waktu dan menggunakan lebih banyak resource.

Untuk UX yang baik, kamu bisa menampilkan last known position lebih dulu, lalu memperbarui setelah current location tersedia. Periksa `timestamp` dan `accuracy` sebelum mempercayai posisi lama.

## 11.5 Location stream untuk tracking

Gunakan stream hanya ketika pengguna memang perlu update lokasi berulang, misalnya tracking perjalanan aktif.

```dart
final subscription = Geolocator.getPositionStream(
  locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 20,
  ),
).listen((position) {
  debugPrint('${position.latitude}, ${position.longitude}');
});

// Saat fitur tracking berhenti atau controller dilepas:
await subscription.cancel();
```

`distanceFilter: 20` berarti sistem baru perlu mengirim pembaruan setelah perangkat bergerak kira-kira sejauh 20 meter, sesuai kemampuan provider lokasi. Nilai itu bukan jaminan akurasi GPS.

Jika stream dikelola oleh `GetxController`, simpan `StreamSubscription<Position>` dan batalkan di `onClose()`. Jangan membiarkan stream berjalan setelah screen/fitur selesai.

## 11.6 Menghitung jarak

```dart
final distanceInMeters = Geolocator.distanceBetween(
  userLatitude,
  userLongitude,
  destinationLatitude,
  destinationLongitude,
);

print('${distanceInMeters.toStringAsFixed(0)} meter');
```

Method ini menghitung jarak garis lurus antar koordinat (geodesic approximation), bukan jarak jalan. Jarak rute perlu Directions/Routing API.

## 11.7 Geocoding: koordinat menjadi alamat

Instal package terpisah:

```bash
flutter pub add geocoding
```

Contoh mengubah koordinat menjadi informasi alamat:

```dart
import 'package:geocoding/geocoding.dart';

Future<String> getAddress(double latitude, double longitude) async {
  final placemarks = await placemarkFromCoordinates(latitude, longitude);

  if (placemarks.isEmpty) return 'Alamat tidak ditemukan';

  final place = placemarks.first;
  return [
    place.street,
    place.subLocality,
    place.locality,
    place.administrativeArea,
  ].where((value) => value != null && value.isNotEmpty).join(', ');
}
```

Geocoding bergantung pada layanan platform/penyedia. Hasilnya dapat kosong, berbeda format, atau terkena batas penggunaan. Jangan menganggap reverse geocoding selalu menghasilkan alamat lengkap.

## 11.8 Menampilkan peta

Untuk Google Maps:

```bash
flutter pub add google_maps_flutter
```

Konsep dasar widget:

```dart
GoogleMap(
  initialCameraPosition: const CameraPosition(
    target: LatLng(-7.7956, 110.3695),
    zoom: 14,
  ),
  myLocationEnabled: true,
  myLocationButtonEnabled: true,
  markers: {
    const Marker(
      markerId: MarkerId('destination'),
      position: LatLng(-7.7956, 110.3695),
      infoWindow: InfoWindow(title: 'Destination'),
    ),
  },
)
```

Peta memerlukan konfigurasi provider dan API key. Ikuti setup resmi untuk Android, batasi API key berdasarkan package name dan SHA certificate fingerprint, serta jangan commit secret yang tidak seharusnya dipublikasikan. `myLocationEnabled` juga bergantung pada permission lokasi yang benar-benar diberikan.

## 11.9 Background location bukan fitur default

Background location berarti aplikasi mengambil lokasi saat pengguna tidak sedang aktif memakai aplikasi. Ini jauh lebih sensitif daripada lokasi foreground.

- Android 10+ memerlukan deklarasi `ACCESS_BACKGROUND_LOCATION` bila app benar-benar perlu lokasi di background.
- Android 11+ memiliki alur pemberian akses background yang lebih ketat; pengguna dapat perlu mengubah izin lewat Settings.
- Google Play membatasi background location untuk use case inti yang memenuhi kebijakan.
- Tracking yang sedang aktif bisa membutuhkan foreground service dengan notification yang terlihat dan konfigurasi service yang sesuai Android versi target.

Jangan meminta `ACCESS_BACKGROUND_LOCATION` hanya agar lokasi lebih mudah diambil. Untuk project latihan basic–intermediate, mulai dengan foreground location saja.

## 11.10 LBS dan privasi

- Jelaskan manfaat sebelum menampilkan system permission dialog.
- Minta lokasi ketika pengguna menjalankan fitur yang membutuhkannya.
- Terima approximate location bila fitur tidak membutuhkan presisi.
- Tangani permission denied, service disabled, timeout, dan hasil null.
- Jangan mengirim koordinat ke backend tanpa alasan dan penjelasan yang jelas.
- Minimalkan retensi riwayat lokasi.
- Matikan subscription ketika fitur selesai.

### Checklist uji LBS

- [ ] Location Services aktif dan mati.
- [ ] Pengguna memberi approximate location.
- [ ] Pengguna memberi precise location.
- [ ] Pengguna menolak permission.
- [ ] Permission dicabut dari Android Settings saat app sudah pernah dibuka.
- [ ] GPS lambat/time out.
- [ ] `getLastKnownPosition()` mengembalikan `null`.
- [ ] Stream benar-benar berhenti saat fitur ditutup.
- [ ] App tetap dapat digunakan bila lokasi tidak tersedia.


---

# 12. Permission dan akses fitur perangkat

Permission adalah izin dari Android/iOS untuk memakai fitur atau data yang dilindungi.

Contoh permission:

| Fitur | Permission/akses yang mungkin dibutuhkan |
|---|---|
| Lokasi | Location |
| Kamera | Camera |
| Galeri/foto | Photos/media access sesuai versi OS |
| Mikrofon | Microphone |
| Notifikasi | Notifications |
| Kontak | Contacts |
| Bluetooth | Bluetooth |

Alur permission yang benar:

```text
Pengguna menjalankan fitur
       │
       ▼
Aplikasi menjelaskan manfaat/tujuan izin
       │
       ▼
Periksa status permission
       ├── Granted → jalankan fitur
       ├── Denied → jelaskan dan tawarkan permintaan ulang
       └── Permanently denied → arahkan ke App Settings jika relevan
```

Permission bukan sekadar memanggil `.request()`. Aplikasi harus siap menghadapi pengguna yang menolak.

Gunakan:

- API permission bawaan package fitur, misalnya `geolocator` untuk lokasi.
- `permission_handler` bila butuh satu pendekatan umum untuk berbagai permission.
- Dokumentasi tiap package untuk konfigurasi `AndroidManifest.xml`, `Info.plist`, dan aturan platform.

Jangan meminta semua permission ketika aplikasi baru dibuka. Minta izin sesuai konteks fitur.

---

# 13. Offline mode, cache, dan sinkronisasi

Aplikasi mobile harus siap menghadapi jaringan yang lambat, terputus, atau tidak stabil.

## 13.1 Connectivity bukan internet guarantee

`connectivity_plus` dapat memberi tahu jenis koneksi seperti Wi-Fi atau mobile data. Namun, Wi-Fi yang tersambung belum tentu memiliki akses internet.

Karena itu:

- Tetap tangani timeout dan kegagalan request.
- Jangan menganggap koneksi Wi-Fi berarti API pasti dapat diakses.
- Gunakan connectivity status sebagai sinyal UX, bukan satu-satunya bukti bahwa server tersedia.

## 13.2 Pola sederhana offline-first

```text
UI
 │
 ▼
Controller
 │
 ▼
Repository
 ├── Baca data lokal → tampilkan dengan cepat
 ├── Request API → ambil versi terbaru
 ├── Simpan hasil API ke local database
 └── Jika request gagal → tetap tampilkan data lokal + status offline
```

Ini disebut pendekatan offline-first. Cocok untuk aplikasi catatan, tugas, tracker, atau aplikasi yang perlu tetap berguna tanpa internet.

## 13.3 Cache vs source of truth

- **Cache:** salinan data untuk mempercepat akses. Bisa dibuang dan diambil ulang.
- **Local source of truth:** data lokal menjadi sumber utama untuk fitur offline.
- **Remote source of truth:** server menjadi sumber utama dan lokal hanya menyimpan salinan.

Tentukan siapa yang menang jika data lokal dan server berbeda. Untuk aplikasi yang mendukung perubahan offline, perlu strategi sinkronisasi dan konflik data.

## 13.4 Prinsip sync dasar

1. Simpan perubahan lokal beserta ID dan waktu perubahan.
2. Tandai data yang belum tersinkronisasi.
3. Saat jaringan tersedia, kirim perubahan ke server.
4. Tangani konflik berdasarkan aturan produk, bukan sekadar menimpa data.
5. Tandai perubahan sebagai tersinkronisasi hanya setelah server mengonfirmasi.

---

# 14. File, gambar, dan berbagi konten

Fitur perangkat yang sering muncul dalam aplikasi:

| Kebutuhan | Package yang dapat dipelajari |
|---|---|
| Ambil foto dari kamera/galeri | `image_picker` |
| Pilih dokumen | `file_picker` |
| Menemukan folder penyimpanan aplikasi | `path_provider` |
| Membuka browser, telepon, email | `url_launcher` |
| Membuka share sheet | `share_plus` |

Hal yang perlu dipahami:

- Path file sementara belum tentu aman untuk disimpan sebagai referensi jangka panjang.
- File besar tidak ideal disimpan sebagai string Base64 di Hive/SharedPreferences.
- Untuk file yang perlu dipertahankan, salin ke direktori aplikasi yang sesuai.
- Permission media/storage berbeda antarversi Android dan iOS; ikuti dokumentasi plugin.
- Saat upload ke backend, pahami multipart/form-data, batas ukuran, progress, dan error handling.

## Fitur mobile lain yang perlu dikenal

| Fitur | Konsep / package | Kapan diperlukan |
|---|---|---|
| Push notification | Firebase Cloud Messaging (`firebase_messaging`) | Server perlu mengirim notifikasi ke perangkat. Berbeda dari local notification yang dijadwalkan aplikasi. |
| Deep link / App link | `app_links` atau mekanisme deep-link Flutter | URL dari browser, email, atau notifikasi harus membuka screen tertentu. |
| Biometric unlock | `local_auth` | Membuka akses lokal dengan sidik jari/wajah. Ini bukan pengganti login dan validasi backend. |
| Background task | `workmanager` | Pekerjaan yang boleh dijalankan sistem di background. Waktu eksekusi tidak selalu tepat karena OS mengatur baterai dan prioritas. |
| Localization | `flutter_localizations` dan `intl` | Aplikasi mendukung lebih dari satu bahasa, format tanggal, angka, atau mata uang. |
| App configuration | `--dart-define` atau konfigurasi environment | Memisahkan base URL development, staging, dan production. Jangan menaruh secret privat di client. |

Pelajari fitur ini setelah UI, state, networking, dan storage dasar sudah dipahami. Implementasi push notification, deep link, dan background task memiliki konfigurasi platform tambahan.

---

# 15. App lifecycle dan pengelolaan resource

Aplikasi dapat berpindah antara foreground, background, inactive, atau terminated. Jangan menganggap aplikasi selalu hidup.

Contoh lifecycle yang perlu dipahami:

- **Resumed:** aplikasi berada di foreground dan dapat menerima interaksi.
- **Inactive:** aplikasi kehilangan fokus interaksi sementara.
- **Paused:** aplikasi tidak sedang terlihat/aktif di foreground.
- **Detached:** engine Flutter tidak terhubung dengan view.

Contoh menggunakan `WidgetsBindingObserver`:

```dart
class LifecyclePage extends StatefulWidget {
  const LifecyclePage({super.key});

  @override
  State<LifecyclePage> createState() => _LifecyclePageState();
}

class _LifecyclePageState extends State<LifecyclePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh data jika diperlukan.
    } else if (state == AppLifecycleState.paused) {
      // Simpan perubahan penting bila diperlukan.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Lifecycle demo')));
  }
}
```

Jangan mengandalkan callback lifecycle sebagai satu-satunya mekanisme penyimpanan data. Simpan perubahan penting sedini mungkin karena OS dapat menghentikan proses aplikasi.

Resource yang perlu ditutup:

- `TextEditingController`
- `AnimationController`
- `StreamSubscription`
- `Timer`
- `FocusNode`
- `ScrollController`
- Worker/listener GetX jika dibuat secara manual

---

# 16. Struktur project dan arsitektur sederhana

Ketika project tumbuh, jangan menaruh semua kode di `main.dart`. Pisahkan berdasarkan tanggung jawab dan fitur.

Contoh struktur feature-first:

```text
lib/
├── main.dart
├── app/
│   ├── routes/
│   ├── bindings/
│   └── theme/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── services/
│   └── utils/
├── data/
│   ├── local/
│   ├── remote/
│   └── repositories/
└── features/
    ├── auth/
    │   ├── bindings/
    │   ├── controllers/
    │   ├── models/
    │   ├── repositories/
    │   └── views/
    ├── home/
    └── tasks/
```

Tidak harus memakai struktur ini persis. Sesuaikan ukuran project. Tujuannya adalah menjaga batas tanggung jawab.

## 16.1 Peran setiap lapisan

| Lapisan | Tanggung jawab | Contoh |
|---|---|---|
| View | Menampilkan UI dan meneruskan interaksi | `TaskPage` |
| Controller / ViewModel | Mengatur state dan alur UI | `TaskController` |
| Repository | Menentukan sumber data dan aturan akses data | `TaskRepository` |
| Service | Berkomunikasi dengan API atau plugin | `ApiService`, `NotificationService` |
| Model | Mewakili bentuk data | `Task`, `User` |

Alur ideal:

```text
View → Controller → Repository → Service / Local database
  ↑         │               │
  └── state berubah ────────┘
```

Controller tidak perlu tahu detail penyimpanan Hive atau bentuk request HTTP. Repository menyembunyikan detail itu.

## 16.2 Contoh batas tanggung jawab

Kurang baik:

```dart
// Di dalam onPressed UI:
// - validasi input
// - request HTTP
// - decode JSON
// - tulis ke Hive
// - ubah route
// - tampilkan error
```

Lebih terstruktur:

```dart
onPressed: controller.saveTask,
```

Kemudian controller memanggil repository, sedangkan repository mengatur sumber data.

---

# 17. Error handling dan UX state

Setiap fitur yang memuat data sebaiknya mempunyai keadaan UI yang jelas.

| State | Tampilan yang sesuai |
|---|---|
| Initial | Tampilan awal atau petunjuk |
| Loading | Progress indicator/skeleton |
| Success | Data berhasil dimuat |
| Empty | Pesan bahwa belum ada data + aksi berikutnya |
| Error | Penjelasan singkat + tombol coba lagi |
| Offline | Penanda data mungkin belum terbaru |

Jangan menampilkan layar kosong tanpa penjelasan ketika request gagal.

Prinsip error handling:

- Tangani error di lapisan yang memahami konteksnya.
- Ubah error teknis menjadi pesan yang dapat dimengerti pengguna.
- Simpan detail teknis untuk debugging, tetapi jangan bocorkan token atau data sensitif.
- Sediakan retry untuk error sementara.
- Hindari `catch (_) {}` yang diam-diam mengabaikan kegagalan tanpa tindakan.

---

# 18. Testing dan debugging

## 18.1 Tiga tingkat testing

| Jenis | Menguji | Contoh |
|---|---|---|
| Unit test | Function/class secara terpisah | Validasi, repository, mapper JSON |
| Widget test | Tampilan dan interaksi widget | Tombol login, error message |
| Integration test | Alur aplikasi secara keseluruhan | Login → Home → tambah transaksi |

Perintah:

```bash
flutter analyze
flutter test
flutter test test/path/to/example_test.dart
```

## 18.2 Apa yang perlu diuji?

- Input kosong dan input tidak valid.
- API sukses, gagal, timeout, dan response tidak sesuai.
- Storage kosong saat pertama kali aplikasi dibuka.
- Token kedaluwarsa dan logout.
- Permission diberikan, ditolak, atau dicabut.
- Lokasi tidak tersedia.
- Aplikasi dibuka tanpa internet.
- Notifikasi dijadwalkan, dibatalkan, dan diketuk.
- Data tetap ada setelah aplikasi ditutup dan dibuka kembali.

## 18.3 Debugging dasar

```bash
flutter doctor -v
flutter devices
flutter logs
flutter analyze
```

Gunakan DevTools untuk memeriksa widget tree, rebuild, memory, dan performa. Baca error log dari bagian paling awal yang relevan; jangan hanya memperbaiki baris terakhir yang terlihat.

---

# 19. Android platform essentials, build, dan release

Flutter membuat sebagian besar UI dan logika dengan Dart. Namun, aplikasi Android tetap dibangun di atas Android project: manifest, Gradle, Android SDK, Activity, permission, dan aturan lifecycle sistem.

## 19.1 Kenali folder Android

```text
android/
├── app/
│   ├── build.gradle.kts           # Konfigurasi module app
│   └── src/main/
│       ├── AndroidManifest.xml    # App declaration, activity, permission
│       ├── kotlin/.../MainActivity.kt
│       └── res/                   # Icon, drawable, values, raw
├── gradle/wrapper/
│   └── gradle-wrapper.properties # Versi Gradle Wrapper
└── settings.gradle.kts            # Plugin dan konfigurasi Gradle project
```

File penting:

- `AndroidManifest.xml`: mendeklarasikan Activity, permission, service, receiver, intent filter, dan metadata.
- `app/build.gradle.kts`: `applicationId`, `minSdk`, `targetSdk`, `compileSdk`, version, dependency, dan konfigurasi Java/Kotlin.
- `settings.gradle.kts`: plugin Gradle dan konfigurasi project.
- `gradle-wrapper.properties`: versi Gradle Wrapper.
- `MainActivity.kt`: host Android Activity yang menjalankan Flutter engine.

Jangan mengubah file native tanpa memahami fungsi file dan versi toolchain.

## 19.2 `compileSdk`, `minSdk`, dan `targetSdk`

| Konfigurasi | Artinya | Dampak |
|---|---|---|
| `compileSdk` | Android API level yang digunakan untuk compile | Menentukan API Android yang tersedia saat build |
| `minSdk` | Android API level minimum yang didukung aplikasi | Perangkat di bawah versi ini tidak dapat memasang app |
| `targetSdk` | Android API level yang perilakunya ditargetkan app | Memengaruhi compatibility behavior dan persyaratan distribusi |

Jangan menaikkan `minSdk` tanpa alasan karena dapat mengurangi perangkat yang didukung. Jangan menurunkan `targetSdk` hanya untuk menghindari permission baru; ikuti persyaratan distribusi dan kebijakan platform yang berlaku.

## 19.3 AndroidManifest dan permission

Permission deklarasi berada di luar `<application>`. Component seperti Activity, Service, dan Receiver berada di dalam `<application>`.

Contoh bentuk manifest (bukan daftar permission yang harus dipasang semuanya):

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.INTERNET" />

    <application
        android:label="My Flutter App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop">
            <!-- Intent filters from Flutter template go here. -->
        </activity>

    </application>
</manifest>
```

Tambahkan permission khusus hanya ketika fitur memang digunakan. Permission umum yang mungkin diperlukan:

| Fitur | Permission/konfigurasi |
|---|---|
| HTTP request | `INTERNET` |
| Lokasi foreground | `ACCESS_COARSE_LOCATION`, dan `ACCESS_FINE_LOCATION` bila perlu |
| Lokasi background | `ACCESS_BACKGROUND_LOCATION` hanya untuk use case yang memenuhi syarat |
| Notifikasi | `POST_NOTIFICATIONS` runtime permission Android 13+ |
| Scheduled notification setelah reboot | `RECEIVE_BOOT_COMPLETED` dan receiver sesuai plugin |
| Exact alarm | `SCHEDULE_EXACT_ALARM` atau akses yang sesuai, hanya jika benar-benar perlu |
| Kamera | `CAMERA` bila package/fitur mengharuskannya |

System permission dialog harus muncul ketika fitur digunakan, bukan meminta semua izin saat splash screen.

## 19.4 Android runtime permission flow

Alur yang baik:

```text
User menekan fitur
        │
        ▼
App menjelaskan alasan permission
        │
        ▼
Periksa status permission
        ├── Granted ───────► Jalankan fitur
        ├── Denied ────────► Tampilkan fallback / minta lagi bila relevan
        └── Denied forever ► Tawarkan tombol App Settings
```

Jangan menyamakan permission dengan status hardware. Contohnya:

- Permission lokasi granted tidak berarti GPS aktif.
- Permission notifikasi granted tidak berarti channel tidak dimatikan pengguna.
- Permission kamera granted tidak menjamin kamera tersedia atau tidak sedang dipakai aplikasi lain.

Selalu sediakan fallback jika fitur tidak tersedia.

## 19.5 Network dan Android

Untuk HTTP request pada Android:

- Deklarasikan `INTERNET` permission untuk build yang membutuhkannya.
- Gunakan HTTPS untuk API produksi.
- Jangan menonaktifkan TLS validation untuk mengatasi error certificate.
- Android modern membatasi cleartext HTTP pada konfigurasi tertentu; gunakan HTTPS daripada menambah pengecualian HTTP.
- Jangan menaruh API secret di source code aplikasi. Nilai yang tertanam di APK dapat diekstrak.
- Tangani request timeout, server error, dan koneksi yang hilang.

## 19.6 App lifecycle dan background work Android

Android dapat menghentikan proses aplikasi ketika memory terbatas. Jangan menganggap kode Dart akan selalu berjalan setelah pengguna menutup app.

| Kebutuhan | Pendekatan |
|---|---|
| Update UI ketika app aktif | Flutter lifecycle + GetX state |
| Reminder pada jam tertentu | Local notification scheduling |
| Sync tertunda yang harus dijalankan OS saat kondisi terpenuhi | WorkManager (`workmanager`) |
| Proses panjang yang sedang berlangsung dan terlihat oleh pengguna | Foreground service dengan notifikasi, sesuai aturan Android |
| Tracking lokasi di background | Use case khusus, permission, foreground service, dan kebijakan platform |

Jangan memakai `Timer.periodic` sebagai mekanisme background task yang harus tetap berjalan ketika app ditutup. Timer Dart tidak menjamin eksekusi saat proses aplikasi dihentikan.

## 19.7 App identity dan versioning

Contoh konfigurasi di `android/app/build.gradle.kts`:

```kotlin
android {
    namespace = "com.example.my_app"

    defaultConfig {
        applicationId = "com.example.my_app"
        minSdk = 23 // Contoh; sesuaikan dengan kebutuhan package dan pengguna.
        targetSdk = flutter.targetSdkVersion
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
    }
}
```

- `applicationId`: identitas aplikasi yang dipakai Android dan store.
- `namespace`: namespace kode Android/manifest.
- `versionCode`: nomor versi integer yang harus meningkat untuk setiap rilis.
- `versionName`: versi yang terlihat pengguna, misalnya `1.0.0`.
- `minSdk`: jangan asal menyalin angka; periksa package yang dipakai.

Contoh di atas mengikuti pola template tertentu; nama variable dapat berbeda antarversi Flutter Gradle plugin.

## 19.8 Build dan release

Debug build untuk pengembangan:

```bash
flutter run
```

Release build:

```bash
flutter build apk --release
flutter build appbundle --release
```

- APK: dapat dipasang langsung untuk pengujian/distribusi tertentu.
- AAB: format yang umum untuk upload ke Google Play.

Sebelum release:

- [ ] Application ID/package name sudah final.
- [ ] App name, launcher icon, version name, dan version code benar.
- [ ] Permission di manifest hanya yang dibutuhkan.
- [ ] API base URL mengarah ke production.
- [ ] Tidak ada API secret/private key yang ditanam di source.
- [ ] Signing key dibuat dan disimpan aman di luar repository.
- [ ] Release build diuji di perangkat nyata.
- [ ] Uji upgrade dari versi aplikasi sebelumnya jika menyimpan data lokal.
- [ ] Periksa crash, log sensitif, notifikasi, dan behavior permission.

## 19.9 Android real-device testing

Emulator berguna, tetapi tidak menggantikan pengujian perangkat nyata. Uji setidaknya:

- Jaringan Wi-Fi dan mobile data.
- Airplane mode dan koneksi yang putus di tengah request.
- Permission granted/denied/revoked.
- App foreground/background/terminated.
- Tombol Back dan gesture navigation.
- Rotasi, ukuran layar berbeda, keyboard terbuka.
- Battery saver dan reboot untuk fitur terjadwal.
- Penyimpanan hampir penuh jika aplikasi banyak menyimpan file.

Perintah debugging yang berguna:

```bash
flutter doctor -v
flutter devices
flutter analyze
flutter logs
adb devices
adb logcat
```

Gunakan `adb logcat` untuk membaca log native Android bila error tidak terlihat jelas pada output Flutter.


---

# 20. Project latihan: Personal Life Hub

Project latihan yang menggabungkan sebagian besar materi di atas adalah aplikasi personal life hub untuk mahasiswa.

## Fitur minimum

| Fitur | Kemampuan yang dilatih |
|---|---|
| Onboarding dan login demo | Navigation, form, session state |
| Dashboard | Layout, GetX, loading/empty state |
| Task/deadline manager | CRUD, Hive, model, local notification |
| Expense tracker | CRUD, validasi, agregasi data lokal |
| Reminder | Local notification, channel, schedule, cancel, timezone |
| Location note | Runtime permission, Geolocator, approximate/precise location, geocoding |
| Profile/settings | SharedPreferences, secure storage untuk token, theme/language preference |
| Bottom navigation | Material 3 NavigationBar, GetX selected index, IndexedStack |
| Optional sync | HTTP/Dio, REST API, repository, offline sync, connectivity state |
| Android integration | Manifest, Gradle, app identity, permission, APK/AAB release |

## Tahapan pengerjaan

1. Bangun UI statis: onboarding, login, dashboard, task list, form, profile.
2. Tambahkan navigation dan GetX controller.
3. Simpan task dan transaksi ke Hive CE.
4. Simpan preferensi tampilan ke SharedPreferences.
5. Tambahkan login API dan simpan token di Secure Storage.
6. Tambahkan local notification untuk deadline.
7. Tambahkan fitur lokasi hanya jika ada kebutuhan nyata.
8. Tambahkan API sync dan penanganan offline.
9. Tambahkan unit/widget test.
10. Buat release build dan uji di perangkat nyata.

**Target akhirnya:** aplikasi tetap dapat menampilkan data penting saat offline, tidak kehilangan session secara sembarangan, menangani error dengan jelas, dan tidak meminta permission tanpa alasan.

---

# Urutan belajar yang disarankan

Urutan ini mengurangi risiko belajar package tanpa memahami konsep yang mendasarinya.

| Tahap | Materi | Hasil latihan |
|---|---|---|
| 1. Fondasi | Dart, OOP, null safety, Future, JSON | Model `Task` dan function CRUD sederhana |
| 2. UI | Widget, layout, form, list, responsive | Task list dan form |
| 3. App flow | Navigation dan GetX | Login demo, dashboard, detail |
| 4. Local data | SharedPreferences, Hive CE, SQLite overview | Data tetap ada setelah app restart |
| 5. Authentication | HTTP, token, secure storage, session restore | Login/logout dan route protection |
| 6. Device features | Permission, notification, location | Reminder dan get current location |
| 7. Reliability | Offline, lifecycle, error handling | Aplikasi tetap masuk akal saat offline |
| 8. Delivery | Testing, debugging, release | APK/AAB yang sudah diuji |

Jangan lanjut ke tahap berikutnya hanya karena berhasil menyalin kode. Pastikan kamu bisa menjelaskan **mengapa** kode itu diperlukan dan **apa yang terjadi jika gagal**.

---

# Checklist kemampuan

Gunakan checklist ini untuk mengukur kesiapan, bukan sebagai daftar hafalan.

## Dart dan Flutter

- [ ] Saya dapat menjelaskan `final`, `const`, nullable type, dan null-aware operator.
- [ ] Saya dapat menggunakan `List`, `Set`, dan `Map`.
- [ ] Saya memahami class, constructor, inheritance, dan encapsulation.
- [ ] Saya memahami `Future`, `async/await`, `Stream`, dan `try/catch`.
- [ ] Saya dapat membuat layout dengan `Row`, `Column`, `Expanded`, dan scrollable widget.
- [ ] Saya dapat membuat form dan validasi.
- [ ] Saya memahami navigation stack dan mengirim data antar-screen.
- [ ] Saya dapat menjelaskan perbedaan state lokal dan app-wide state.

## GetX

- [ ] Saya dapat membuat `GetxController`.
- [ ] Saya memahami `.obs`, `.value`, dan `Obx`.
- [ ] Saya dapat mendaftarkan dependency dengan `Get.put`/`Get.lazyPut`.
- [ ] Saya dapat menggunakan Binding dan named route.
- [ ] Saya tahu kapan harus membersihkan controller/resource.

## Data dan backend

- [ ] Saya dapat membuat GET dan POST request.
- [ ] Saya dapat mengubah JSON menjadi model Dart.
- [ ] Saya dapat menangani status code, timeout, dan request failure.
- [ ] Saya memahami kapan memakai SharedPreferences, Secure Storage, Hive, dan SQLite.
- [ ] Saya dapat membuat CRUD lokal.
- [ ] Saya dapat menjelaskan access token, refresh token, session restore, dan logout.
- [ ] Saya tidak menyimpan credential sensitif di storage biasa.

## Fitur perangkat dan reliability

- [ ] Saya dapat meminta permission pada konteks yang tepat.
- [ ] Saya dapat membuat local notification dasar.
- [ ] Saya memahami channel, schedule, payload, dan cancel notification.
- [ ] Saya dapat mengambil lokasi dengan permission yang tepat.
- [ ] Saya dapat menangani permission denied dan location service disabled.
- [ ] Saya memahami perbedaan koneksi jaringan dan akses internet.
- [ ] Saya dapat membuat loading, empty, error, dan offline state.
- [ ] Saya dapat melakukan unit test dan widget test dasar.
- [ ] Saya dapat membuat release build Android.

---

# Kesalahan yang sering terjadi

| Kesalahan | Mengapa bermasalah | Perbaikan |
|---|---|---|
| Menaruh semua kode di `main.dart` | Sulit diuji dan dirawat | Pisahkan fitur, controller, repository, service |
| Request API di dalam `build()` | Rebuild dapat mengulang request | Panggil dari controller/init/event yang tepat |
| Menyimpan token di SharedPreferences/Hive biasa | Storage tersebut bukan pilihan untuk credential sensitif | Gunakan secure storage |
| Menganggap token ada berarti session valid | Token bisa expired atau dicabut | Validasi/refresh dengan backend |
| Menggunakan Hive untuk semua jenis data | Hive bukan relational database | Pilih storage berdasarkan struktur data |
| Menganggap Wi-Fi berarti internet tersedia | Bisa tersambung ke router tanpa internet | Tangani error request dan timeout |
| Meminta semua permission saat startup | UX buruk dan pengguna bisa menolak | Minta izin ketika fitur digunakan |
| Mengakses lokasi di background tanpa kebutuhan | Boros baterai dan memerlukan izin/kebijakan tambahan | Mulai dari `while in use` |
| Tidak dispose controller/subscription | Risiko memory leak atau callback setelah widget hilang | Bersihkan resource pada lifecycle yang tepat |
| Menangkap error lalu mengabaikannya | Bug sulit ditemukan dan pengguna tidak mendapat feedback | Tampilkan error yang sesuai dan catat detail aman |
| Menaruh secret backend di aplikasi | File aplikasi dapat dianalisis | Simpan secret di server |
| Menyalin tutorial package versi lama | API dan konfigurasi native dapat berubah | Cocokkan dengan versi package di `pubspec.lock` |

---

# Referensi resmi

Gunakan dokumentasi ini ketika membutuhkan konfigurasi atau API yang lebih lengkap. README ini adalah peta belajar, bukan pengganti dokumentasi package.

## Flutter dan Dart

- [Flutter documentation](https://docs.flutter.dev/)
- [Flutter app architecture guide](https://docs.flutter.dev/app-architecture/guide)
- [Flutter networking cookbook](https://docs.flutter.dev/cookbook/networking)
- [Flutter testing](https://docs.flutter.dev/testing)
- [Dart language tour](https://dart.dev/language)
- [Flutter Material UI migration](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui)
- [Android developer documentation](https://developer.android.com/develop)
- [Android runtime permissions](https://developer.android.com/training/permissions/requesting)
- [Android location permissions](https://developer.android.com/develop/sensors-and-location/location/permissions)
- [Android notification permission](https://developer.android.com/develop/ui/views/notifications/notification-permission)
- [Android exact alarms](https://developer.android.com/develop/background-work/services/alarms)

## Package

- [GetX (`get`)](https://pub.dev/packages/get)
- [HTTP](https://pub.dev/packages/http)
- [Dio](https://pub.dev/packages/dio)
- [Hive CE](https://pub.dev/packages/hive_ce)
- [Hive CE Flutter](https://pub.dev/packages/hive_ce_flutter)
- [Hive CE Generator](https://pub.dev/packages/hive_ce_generator)
- [Build Runner](https://pub.dev/packages/build_runner)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- [Geolocator](https://pub.dev/packages/geolocator)
- [Flutter Timezone](https://pub.dev/packages/flutter_timezone)
- [Timezone](https://pub.dev/packages/timezone)
- [Workmanager](https://pub.dev/packages/workmanager)
- [Geocoding](https://pub.dev/packages/geocoding)
- [Permission Handler](https://pub.dev/packages/permission_handler)
- [Connectivity Plus](https://pub.dev/packages/connectivity_plus)
- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
- [Image Picker](https://pub.dev/packages/image_picker)
- [Path Provider](https://pub.dev/packages/path_provider)

---

## Prinsip yang perlu diingat

1. **Pahami data sebelum memilih package.**
2. **Pisahkan UI, state, dan akses data.**
3. **Simpan data sensitif dengan mekanisme yang sesuai.**
4. **Anggap jaringan, permission, dan proses aplikasi bisa gagal kapan saja.**
5. **Bangun fitur kecil sampai benar-benar bekerja sebelum menambah fitur lain.**

Kalau lima prinsip ini dipahami, kamu sudah punya fondasi yang baik untuk membangun aplikasi Flutter basic–intermediate yang lebih stabil dan mudah dikembangkan.
