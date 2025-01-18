import 'package:flutter/material.dart';
// import 'package:menu_app/main.dart';
import 'package:menu_app/utilities/constants.dart' as constants;
import 'package:menu_app/utilities/prefs_service.dart';
// import 'package:menu_app/utilities/prefs_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/theme_provider.g.dart';

const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    //
    primary: constants.defaultPrimary,
    onPrimary: Color.fromARGB(255, 139, 139, 139),
    //
    secondary: constants.defaultSecondary,
    onSecondary: Color(0xFFEAEAEA),
    // tertiary: Colors.orange,
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    surface: Color(0xff0f0f0f),
    onSecondaryContainer: Colors.black,
    secondaryContainer: Colors.white,
    inverseSurface: Color.fromARGB(255, 139, 139, 139),
    primaryContainer: Color.fromARGB(255, 30, 30, 30),
    // onSurface: Color(0xFF202020),
    onSurface: Color(0xffdbdbdb),
    onSurfaceVariant: Color(0xFF202020));

class AppThemeData {
  final bool isDefault;
  final ColorScheme colorScheme;

  AppThemeData({
    required this.isDefault,
    required this.colorScheme,
  });

  AppThemeData copyWith({
    bool? isDefault,
    ColorScheme? colorScheme,
  }) {
    return AppThemeData(
      isDefault: isDefault ?? this.isDefault,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }
}

@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  late Color _otherPrimary;
  late Color _otherSecondary;

  @override
  AppThemeData build() {
    // return AppThemeData(isDefault: true, colorScheme: colorScheme);
    final prefs = PrefsService.instance;
    final isDefault = prefs.getBool('isDefaultTheme') ?? true;
    _otherPrimary = Color(prefs.getInt('otherPrimaryTheme') ?? 0xFF2098DF);
    _otherSecondary = Color(prefs.getInt('otherSecondaryTheme') ?? 0xFF0004FF);
    return AppThemeData(
        isDefault: isDefault,
        colorScheme: isDefault
            ? colorScheme
            : colorScheme.copyWith(
                primary: _otherPrimary, secondary: _otherSecondary));
  }

  void updateTheme(
      {bool? isDefault, Color? otherPrimary, Color? otherSecondary}) {
    _otherPrimary = otherPrimary ?? _otherPrimary;
    _otherSecondary = otherSecondary ?? _otherSecondary;
    state = state.copyWith(
      isDefault: isDefault,
      colorScheme: colorScheme.copyWith(
        primary: isDefault ?? state.isDefault
            ? constants.defaultPrimary
            : _otherPrimary,
        secondary: isDefault ?? state.isDefault
            ? constants.defaultSecondary
            : _otherSecondary,
      ),
    );

    final prefs = PrefsService.instance;
    if (isDefault != null) {
      prefs.setBool('isDefaultTheme', isDefault);
    }
    if (otherPrimary != null) {
      prefs.setInt('otherPrimaryTheme', _otherPrimary.value);
    }
    if (otherSecondary != null) {
      prefs.setInt('otherSecondaryTheme', _otherSecondary.value);
    }
  }
}


// ColorScheme _darkThemeColors(
//     {required Color primary, required Color secondary}) {
//   return ColorScheme(
//       brightness: Brightness.dark,
//       //
//       primary: primary,
//       onPrimary: const Color.fromARGB(255, 139, 139, 139),
//       //
//       secondary: secondary,
//       onSecondary: const Color(0xFFEAEAEA),
//       // tertiary: Colors.orange,
//       error: const Color(0xFFF32424),
//       onError: const Color(0xFFF32424),
//       surface: const Color(0xff0f0f0f),
//       onSecondaryContainer: Colors.black,
//       secondaryContainer: Colors.white,
//       inverseSurface: const Color.fromARGB(255, 139, 139, 139),

//       // onSurface: Color(0xFF202020),
//       onSurface: const Color(0xffdbdbdb),
//       onSurfaceVariant: const Color(0xFF202020));
// }

// class ThemeProvider extends ChangeNotifier {
//   bool _isDefault = true;
//   Color _otherPrimary = constants.defaultPrimary;
//   Color _otherSecondary = constants.defaultSecondary;
//   ColorScheme _colorScheme = _darkThemeColors(
//       primary: constants.defaultPrimary, secondary: constants.defaultSecondary);

//   bool get isDefault => _isDefault;
//   ColorScheme get colorScheme => _colorScheme;
  
//   ThemeProvider() {
//     _init();
//   }

//   Future<void> _init() async {
//     final prefs = PrefsService.instance;
//     _isDefault = prefs.getBool('isDefaultTheme') ?? true;
//     _otherPrimary = Color(prefs.getInt('otherPrimaryTheme') ?? 0xFF2098DF);
//     _otherSecondary = Color(prefs.getInt('otherSecondaryTheme') ?? 0xFF0004FF);
//     _updateTheme();
//     notifyListeners();
//   }



//   void setPrimary(Color color) {
//     _otherPrimary = color;
//     _updateTheme();
//     notifyListeners();
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setInt('otherPrimaryTheme', color.value);
//     });
//   }

//   void setSecondary(Color color) {
//     _otherSecondary = color;
//     _updateTheme();
//     notifyListeners();
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.setInt('otherSecondaryTheme', color.value);
//     });
//   }

//   void _updateTheme() {
//     if (_isDefault) {
//       _colorScheme = _darkThemeColors(
//           primary: constants.defaultPrimary,
//           secondary: constants.defaultSecondary);
//     } else {
//       _colorScheme =
//           _darkThemeColors(primary: _otherPrimary, secondary: _otherSecondary);
//     }
//   }
// }
