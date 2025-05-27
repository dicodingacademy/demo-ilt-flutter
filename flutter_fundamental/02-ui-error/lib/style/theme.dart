import 'package:flutter/material.dart';

// Warna utama yang terinspirasi dari rambut Gaara
const Color gaaraRed = Color(0xFF8B0000); // Merah tua (DarkRed)
const Color gaaraRedLight = Color(
  0xFFA52A2A,
); // Merah kecoklatan (Brown) sebagai aksen atau variasi

// Warna dasar untuk tema gelap
const Color darkThemeBackground = Color(
  0xFF121212,
); // Latar belakang umum yang sangat gelap
const Color darkThemeSurface = Color(
  0xFF1E1E1E,
); // Latar belakang untuk Card, Dialog, dll.
const Color darkThemePrimaryText = Colors.white;
const Color darkThemeSecondaryText = Colors.white70;
const Color darkThemeDisabledText = Colors.white38;
const Color darkThemeInputBorder = Colors.white24;
const Color darkThemeInputFill = Color(
  0xFF2C2C2C,
); // Warna isian input yang sedikit lebih terang dari surface

final ThemeData gaaraTheme = ThemeData(
  // Skema Warna
  colorScheme: ColorScheme.fromSeed(
    seedColor: gaaraRed,
    primary: gaaraRed,
    secondary: gaaraRedLight,
    // Warna error bisa disesuaikan, misalnya merah yang lebih terang
    error: Colors.redAccent,
    // Warna latar bisa menggunakan warna netral atau warna pasir
    surface: Colors.white, // atau sandYellow.withOpacity(0.2)
    onPrimary: Colors.white, // Teks/ikon di atas warna primer
    onSecondary: Colors.white, // Teks/ikon di atas warna sekunder
    onSurface: Colors.black87, // Teks/ikon di atas warna permukaan
    onError: Colors.white, // Teks/ikon di atas warna error
    brightness:
        Brightness.light, // Bisa juga Brightness.dark jika ingin tema gelap
  ),

  // Warna Primer (digunakan untuk AppBar, FloatingActionButton, dll.)
  primaryColor: gaaraRed,
  primaryColorLight: gaaraRedLight,
  primaryColorDark: const Color(0xFF610000), // Versi lebih gelap dari gaaraRed
  // Warna Aksen (digunakan untuk highlight, progress bar, dll.)
  // Di Flutter versi baru, `accentColor` sudah deprecated dan digantikan oleh `colorScheme.secondary`.
  // Namun, jika Anda menggunakan versi Flutter yang lebih lama, Anda bisa set `accentColor`.
  // accentColor: gaaraRedLight, // Sudah diatur melalui colorScheme.secondary

  // Warna Latar Belakang Scaffold
  scaffoldBackgroundColor:
      Colors.grey[100], // Latar belakang yang sedikit abu-abu atau putih
  // Tema AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: gaaraRed,
    foregroundColor: Colors.white, // Warna untuk judul dan ikon di AppBar
    elevation: 4.0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),

  // Tema Tombol
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: gaaraRed, // Warna latar tombol
      foregroundColor: Colors.white, // Warna teks tombol
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: gaaraRed, // Warna teks tombol
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: gaaraRed, // Warna teks dan border tombol
      side: const BorderSide(color: gaaraRed, width: 1.5),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Tema Input Dekorasi (untuk TextField)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withValues(alpha: 0.8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: gaaraRed, width: 2.0),
    ),
    labelStyle: const TextStyle(color: gaaraRed),
    hintStyle: TextStyle(color: Colors.grey[500]),
  ),

  // Tema Ikon
  iconTheme: const IconThemeData(
    color: gaaraRed, // Warna default untuk ikon
  ),

  // Tema Teks
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 57.0,
      fontWeight: FontWeight.bold,
      color: gaaraRed,
    ),
    displayMedium: TextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.bold,
      color: gaaraRed,
    ),
    displaySmall: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      color: gaaraRed,
    ),
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    titleLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    titleMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black87),
    bodySmall: TextStyle(fontSize: 12.0, color: Colors.black54),
    labelLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: gaaraRed,
    ),
    labelMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: gaaraRed,
    ),
    labelSmall: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: gaaraRed,
    ),
  ).apply(
    // Anda bisa menerapkan warna default untuk body dan display jika diperlukan
    // bodyColor: Colors.black87,
    // displayColor: gaaraRed,
  ),

  // Tema Card
  cardTheme: CardThemeData(
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    margin: const EdgeInsets.all(8.0),
    color: Colors.white,
  ),

  // Tema FloatingActionButton
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: gaaraRed,
    foregroundColor: Colors.white,
  ),

  // Tema Divider
  dividerTheme: DividerThemeData(color: Colors.grey[300], thickness: 1),

  // Anda bisa menambahkan kustomisasi lain di sini
  // misalnya untuk BottomNavigationBar, TabBar, Dialog, dll.
);

final ThemeData gaaraDarkTheme = ThemeData(
  brightness: Brightness.dark, // Penting untuk menandakan ini tema gelap
  // Skema Warna
  colorScheme: ColorScheme.fromSeed(
    seedColor: gaaraRed,
    brightness: Brightness.dark,
    primary: gaaraRed,
    onPrimary: Colors.white, // Teks/ikon di atas warna primer (gaaraRed)
    secondary: gaaraRedLight,
    onSecondary:
        Colors.white, // Teks/ikon di atas warna sekunder (gaaraRedLight)
    error:
        Colors.redAccent[100] ??
        Colors.redAccent, // Merah error yang lebih terang untuk tema gelap
    onError: Colors.black, // Teks/ikon di atas warna error
    surface: darkThemeSurface,
    onSurface:
        darkThemePrimaryText, // Teks/ikon di atas warna permukaan (mis. Card)
  ),

  // Warna Primer (bisa tetap sama atau disesuaikan jika perlu)
  primaryColor: gaaraRed,
  primaryColorLight: gaaraRedLight,
  primaryColorDark: const Color(0xFF610000),

  // Warna Latar Belakang Scaffold
  scaffoldBackgroundColor: darkThemeBackground,

  // Tema AppBar
  appBarTheme: AppBarTheme(
    backgroundColor:
        gaaraRed, // Atau bisa juga darkThemeSurface jika ingin lebih gelap
    foregroundColor: Colors.white,
    elevation: 0, // Seringkali elevasi dikurangi atau dihilangkan di tema gelap
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),

  // Tema Tombol
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: gaaraRed,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor:
          gaaraRedLight, // Warna teks tombol agar kontras di tema gelap
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: gaaraRedLight,
      side: BorderSide(color: gaaraRedLight, width: 1.5),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // Tema Input Dekorasi (untuk TextField)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: darkThemeInputFill,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: darkThemeInputBorder, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: gaaraRedLight, width: 2.0),
    ),
    labelStyle: TextStyle(color: gaaraRedLight.withValues(alpha: 0.9)),
    hintStyle: TextStyle(color: darkThemeSecondaryText.withValues(alpha: 0.6)),
  ),

  // Tema Ikon
  iconTheme: IconThemeData(
    color: gaaraRedLight, // Atau darkThemeSecondaryText jika ingin lebih netral
  ),

  // Tema Teks
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 57.0,
      fontWeight: FontWeight.bold,
      color: gaaraRedLight,
    ),
    displayMedium: TextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.bold,
      color: gaaraRedLight,
    ),
    displaySmall: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      color: gaaraRedLight,
    ),
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
      color: darkThemePrimaryText,
    ),
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w600,
      color: darkThemePrimaryText,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: darkThemePrimaryText,
    ),
    titleLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w500,
      color: darkThemePrimaryText,
    ),
    titleMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: darkThemePrimaryText,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: darkThemePrimaryText,
    ),
    bodyLarge: TextStyle(fontSize: 16.0, color: darkThemeSecondaryText),
    bodyMedium: TextStyle(fontSize: 14.0, color: darkThemeSecondaryText),
    bodySmall: TextStyle(fontSize: 12.0, color: darkThemeDisabledText),
    labelLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: gaaraRedLight,
    ),
    labelMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: gaaraRedLight,
    ),
    labelSmall: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      color: gaaraRedLight,
    ),
  ).apply(
    bodyColor: darkThemeSecondaryText,
    displayColor: darkThemePrimaryText, // Warna default jika tidak di-override
  ),

  // Tema Card
  cardTheme: CardThemeData(
    elevation: 1.0, // Elevasi bisa dikurangi di tema gelap
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    margin: const EdgeInsets.all(8.0),
    color: darkThemeSurface,
  ),

  // Tema FloatingActionButton
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: gaaraRed,
    foregroundColor: Colors.white,
  ),

  // Tema Divider
  dividerTheme: DividerThemeData(
    color: Colors.white12, // Warna divider yang lembut untuk tema gelap
    thickness: 1,
  ),
);
