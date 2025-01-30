// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:menu_app/utilities/prefs_service.dart';

// class CalculatorController extends ChangeNotifier {
//   CalculatorController() {
//     loadValuesFromSharedPreferences();
//   }

//   // Create default variables.
//   static const totalSlugPoints = 1000.0;
//   static const mealDay = 3.0;
//   static const mealCost = 12.23;

//   // Create text controllers so user may edit.
//   final totalSlugPointsController =
//       TextEditingController(text: totalSlugPoints.toString());
//   final mealDayController = TextEditingController(text: mealDay.toString());
//   final mealCostController = TextEditingController(text: mealCost.toString());
//   final dateController = TextEditingController(
//       text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

//   // Function to load values from shared preferences.
//   void loadValuesFromSharedPreferences() {
//     final prefs = PrefsService.instance;

//     totalSlugPointsController.text =
//         '${prefs.getDouble('totalSlugPoints') ?? 1000.0}';
//     mealDayController.text = '${prefs.getDouble('mealDay') ?? 3.0}';
//     mealCostController.text = '${prefs.getDouble('mealCost') ?? 12.23}';
//     dateController.text = calculateDate();
//     notifyListeners();
//   }

//   // Display ad.
//   changeAdVar(value) {
//     final prefs = PrefsService.instance;
//     prefs.setBool('showAd', value);
//   }

//   // Method to update totalSlugPoints
//   void updateTotalSlugPoints() {
//     notifyListeners();
//     double? val = double.tryParse(totalSlugPointsController.text);
//     if (val != null) {
//       final prefs = PrefsService.instance;
//       prefs.setDouble('totalSlugPoints', val);
//       if (val == 27182818.0) {
//         changeAdVar(false);
//       } else if (val == 31415926.0) {
//         changeAdVar(true);
//       }
//     }
//   }

//   // Method to update mealDay
//   void updateMealDay() {
//     notifyListeners();
//     double? val = double.tryParse(mealDayController.text);
//     if (val != null) {
//       final prefs = PrefsService.instance;
//       prefs.setDouble('mealDay', val);
//     }
//   }

//   // Method to update mealCost
//   void updateMealCost() {
//     notifyListeners();
//     double? val = double.tryParse(mealCostController.text);
//     if (val != null) {
//       final prefs = PrefsService.instance;
//       prefs.setDouble('mealCost', val);
//     }
//   }

//   // Method to update mealDate
//   void updateMealDate(String newValue) {
//     dateController.text = newValue;
//     notifyListeners();
//   }

//   String calculateDate() {
//     final DateTime winter = DateTime(DateTime.now().year, 3, 24);
//     final DateTime spring = DateTime(DateTime.now().year, 6, 15);
//     final DateTime summer = DateTime(DateTime.now().year, 9, 1);
//     final DateTime fall = DateTime(DateTime.now().year, 12, 9);
//     final DateTime now = DateTime.now();
//     final DateFormat formatter = DateFormat('yyyy-MM-dd');

//     // Set default end date based on current date.
//     if (winter.isAfter(now)) {
//       return formatter.format(winter);
//     } else if (spring.isAfter(now)) {
//       return formatter.format(spring);
//     } else if (summer.isAfter(now)) {
//       return formatter.format(summer);
//     } else if (fall.isAfter(now)) {
//       return formatter.format(fall);
//     } else {
//       return formatter.format(now);
//     }
//   }

//   void hideKeyboard() {
//     FocusManager.instance.primaryFocus?.unfocus();
//   }

//   num getDays() {
//     return num.parse(
//         (DateTime.parse(dateController.text).difference(DateTime.now()).inDays +
//                 1)
//             .toString());
//   }

//   double getTotalSlugPoints() {
//     return double.tryParse(totalSlugPointsController.text) ?? 0;
//   }

//   double getMealDay() {
//     return double.tryParse(mealDayController.text) ?? 0;
//   }

//   double getMealCost() {
//     return double.tryParse(mealCostController.text) ?? 0;
//   }

//   String getMealAmount() {
//     return ((getTotalSlugPoints() -
//                 (getMealDay() * getMealCost() * getDays())) /
//             getMealCost())
//         .toStringAsFixed(2);
//   }

//   String getPointsAmount() {
//     return ((getTotalSlugPoints() - (getMealDay() * getMealCost() * getDays())))
//         .toStringAsFixed(2);
//   }

//   String getMealDayAmount() {
//     return (((getTotalSlugPoints() / getMealCost()) / getDays()))
//         .toStringAsFixed(2);
//   }
// }
