// Constants file to keep consistent formatting across app.
import 'package:flutter/material.dart';

//id is used to store order in shared prefs, path is the router name and name is what is displayed
enum Colleges {
  nine(id: 'Nine', name: 'Nine', pathName: '/nine', hasLateNight: true),
  cowell(id: 'Cowell', name: 'Cowell', pathName: '/cowell', hasLateNight: true),
  oakes(id: 'Oakes', name: 'Oakes', pathName: '/oakes', hasLateNight: true),
  merrill(
      id: 'Merrill',
      name: 'Merrill',
      pathName: '/merrill',
      hasLateNight: true),
  porter(id: 'Porter', name: 'Porter', pathName: '/porter', hasLateNight: true);

  const Colleges(
      {required this.id,
      required this.name,
      required this.pathName,
      required this.hasLateNight});
  final String id;
  final String name;
  final String pathName;
  final bool hasLateNight;
}

enum GetPinAllowedOptions {
  seconds3(name: '3s', seconds: 3),
  seconds30(name: '30s', seconds: 30),
  minutes5(name: '5m', seconds: 5 * 60),
  minutes30(name: '30m', seconds: 30 * 60),
  days1(name: '1d', seconds: 24 * 60 * 60),
  never(name: 'Never', seconds: -1);

  const GetPinAllowedOptions({required this.name, required this.seconds});
  final String name;
  final int seconds;
}

const daysOfWeek = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];
const int defaultGetPinAllowedSeconds = 3;
const int provTTL = 1;
// Colors
// const darkBlue = 0xff0f0f0f; //0xff000237
// const yellowGold = 0xFFFFC82F;
// const yellowOrange = 0xFFF29813;
const white = 0xffdbdbdb;
const bool enableBiometric = false;
// App Heading
const double menuHeadingSize = 30;
const double backArrowSize = 30;
const double navigationBarTextSize = 16;

// Menu Pages Title
const double borderWidth = 2;
const double containerPaddingTitle = 12;
const double titleFontSize = 23;
const double titleFontheight = 0.9;
const darkGray = 0xff383838;
const titleColor = white;
const subTitleColor = 0xff939393;
const titleFont = 'Montserat';

// Menu Pages Body
const double containerPaddingbody = 5;
const double bodyFontSize = 18;
const double bodyFontheight = 1.5;
const bodyColor = white;
const bodyFont = 'Montserat';
const double infoFontsize = 22;

// Hours Open
const double sizedBox = 210;

// Nav Drawer
const backgroundColor = 0xff121212;
const double menuFontSize = 21;
const double menuFontheight = 1;
const menuColor = white;
const menuFont = 'Montserat';

// Settings
const listColor = 0xff363636;

//animation
const aniLength = 150;

const Color defaultPrimary = Color(0xFFFFC82F);
const Color defaultSecondary = Color(0xFFF29813);
//Dark

// ColorScheme greenThemeColors(context) {
//   return const ColorScheme(
//       brightness: Brightness.dark,
//       //
//       primary: Color.fromARGB(255, 153, 252, 137),
//       onPrimary: Color.fromARGB(255, 139, 139, 139),
//       //
//       secondary: Color.fromARGB(255, 89, 202, 74),
//       onSecondary: Color(0xFFEAEAEA),
//       // tertiary: Colors.orange,
//       error: Color(0xFFF32424),
//       onError: Color(0xFFF32424),
//       surface: Color(0xff0f0f0f),
//       onSecondaryContainer: Colors.black,
//       secondaryContainer: Colors.white,
//       inverseSurface: Color.fromARGB(255, 139, 139, 139),

//       // onSurface: Color(0xFF202020),
//       onSurface: Color(0xffdbdbdb),
//       onSurfaceVariant: Color(0xFF202020));
// }

InputDecoration customInputDecoration = InputDecoration(
  hintStyle: const TextStyle(color: Color(bodyColor)),
  labelStyle: const TextStyle(
      fontSize: 25,
      letterSpacing: 1,
      fontWeight: FontWeight.bold,
      color: Color(bodyColor)),
  fillColor: const Color.fromARGB(255, 32, 32, 32),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(
      color: Color.fromARGB(255, 52, 52, 52),
    ),
  ),
  // Set the border color when focused
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  ),
);

TextStyle containerTextStyle = const TextStyle(
  fontFamily: titleFont,
  fontWeight: FontWeight.bold,
  fontSize: titleFontSize,
  color: Color(titleColor),
  height: titleFontheight,
);

TextStyle modalTitleStyle = const TextStyle(
  fontFamily: titleFont,
  fontWeight: FontWeight.bold,
  fontSize: 17,
  color: Colors.black,
  height: titleFontheight,
);

TextStyle modalSubtitleStyle = const TextStyle(
  fontFamily: bodyFont,
  color: Colors.black,
  fontSize: 13,
);
