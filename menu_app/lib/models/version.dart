import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<bool> performVersionCheck() async {
  // Retrieve the current app version from the Firebase Realtime Database
  String firebaseAppVersion = await getAppVersionFromFirebase();

  // Get the current app version
  String currentAppVersion = (await getCurrentAppVersion()).version;
  // Compare versions
  if (compareVersions(currentAppVersion, firebaseAppVersion) >= 0) {
    // App is up-to-date or newer
    return true;
  } else {
    return false;
  }
}

// Function to retrieve the current app version
Future<PackageInfo> getCurrentAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo;
}

// Replace this function with the actual function to retrieve the version from Firebase
Future<String> getAppVersionFromFirebase() async {
  bool ios = Platform.isIOS;
  bool android = Platform.isAndroid;
  String path = "";
  if (ios) {
    path = "Version/ios";
  }
  else if (android) {
    path = "Version/android";
  }
  else {
    return '1.0.0';
  }
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child(path).get();
  if (snapshot.exists && snapshot.value != '') {
    return snapshot.value as String;
  }
  return '1.0.0';
}

int compareVersions(String a, String b) {
  List<int> aParts = a.split('.').map(int.parse).toList();
  List<int> bParts = b.split('.').map(int.parse).toList();

  for (int i = 0; i < aParts.length; i++) {
    if (i >= bParts.length) {
      return 1; // a is greater
    }

    if (aParts[i] > bParts[i]) {
      return 1;
    } else if (aParts[i] < bParts[i]) {
      return -1;
    }
  }

  if (aParts.length < bParts.length) {
    return -1; // b is greater
  }

  return 0; // Versions are equal
}