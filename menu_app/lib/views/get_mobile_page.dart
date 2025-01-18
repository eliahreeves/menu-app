import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menu_app/providers/get_auth_notifier.dart';
import 'package:menu_app/views/get_login_page.dart';
import 'package:menu_app/views/barcode_page.dart';


class GetMobilePage extends ConsumerWidget {
  const GetMobilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authNotifierProvider);
    print('auth: ${auth}');
    return auth.sessionId == null 
        ? const GetLoginPage() 
        : const BarcodePage();
  }
}