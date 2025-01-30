import 'dart:async';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_app/custom_widgets/key_pad.dart';
import 'package:menu_app/providers/balance_provider.dart';
import 'package:menu_app/providers/bar_code_stream.dart';
import 'package:menu_app/providers/get_auth_notifier.dart';
import 'package:menu_app/providers/user_provider.dart';
import 'package:menu_app/utilities/prefs_service.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:menu_app/utilities/constants.dart' as constants;
import 'package:local_auth/local_auth.dart';

class BarcodePage extends ConsumerStatefulWidget {
  const BarcodePage({super.key});

  @override
  ConsumerState<BarcodePage> createState() => _BarCodePageState();
}

class _BarCodePageState extends ConsumerState<BarcodePage> {
  late bool isLocked;
  final controller = TextEditingController();

  Timer? _timer;
  bool _showError = false;
  double _rotation = 0;

  @override
  void initState() {
    super.initState();
    isLocked = ref.read(authNotifierProvider.notifier).isPINEntryRequired();
    if (!isLocked) {
      ScreenBrightness.instance.setApplicationScreenBrightness(1);
    } else {
      _checkBioAuth();
    }
  }

  void _checkBioAuth() async {
    final prefs = PrefsService.instance;
    if (prefs.getBool('get_bio_auth_enabled') ?? constants.enableBiometric) {
    try{
      final bool didAuthenticate = await LocalAuthentication().authenticate(
          localizedReason: 'Please authenticate to show code',
          options: const AuthenticationOptions());
      setState(() {
        isLocked = !didAuthenticate;
      });
      } catch (e){
        debugPrint("Failed Bio Auth");
        debugPrintStack();
      }
    }
  }

  @override
  void dispose() {
    ScreenBrightness.instance.resetApplicationScreenBrightness();
    controller.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balance = ref.watch(getBalanceProvider);
    final user = ref.watch(getUserProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: const Color.fromARGB(255, 60, 60, 60),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.secondary,
              size: constants.backArrowSize),
        ),
        title: Text(
          'Scan',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'Monoton',
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              onTap: () async {
                await ref.read(authNotifierProvider.notifier).logout();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: isLocked ? 0 : 1,
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 7),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              width: 5,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            )),
                        child: IndexedStack(
                            alignment: Alignment.bottomRight,
                            index: _showError ? 1 : 0,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  "images/app_icon.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ClipRRect(
                                child: Container(
                                  width: 120,
                                  transformAlignment: Alignment.center,
                                  transform: Matrix4.rotationZ(
                                    _rotation, // here
                                  ),
                                  child: Image.asset(
                                    'icons/error.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ]))),
              ),
              const Text(
                "PIN can be disabled in settings.\nLog out to reset pin.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: constants.titleFont,
                  fontSize: 15,
                  color: Color.fromARGB(255, 145, 145, 145),
                  height: constants.titleFontheight,
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: KeyPad(
                  controller: controller,
                  onFull: (pin) {
                    if (ref
                        .read(authNotifierProvider.notifier)
                        .validatePin(pin)) {
                      setState(() {
                        isLocked = false;
                        ScreenBrightness.instance
                            .setApplicationScreenBrightness(1);
                      });
                      return true;
                    } else {
                      setState(() {
                        _showError = true;
                      });
                      if (_timer != null) {
                        _timer!.cancel();
                      }

                      for (int i = 1; i <= 8; i++) {
                        _timer = Timer(Duration(milliseconds: i * 300), () {
                          setState(() {
                            _rotation = i % 2 == 0 ? -0.1 : 0.75;
                            if (i == 8) {
                              _showError = false;
                            }
                          });
                        });
                      }
                      return false;
                    }
                  },
                ),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 14, right: 14, top: 14, bottom: 14),
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        width: 6,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        "images/app_icon.png",
                        width: 240,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _InfoCard(
                    label: 'Name',
                    value: user == null ? '' : user.toString(),
                    icon: Icons.person_outline,
                  ),
                  _InfoCard(
                    label: 'Balance',
                    value: balance.when(
                      data: (data) => data != null
                          ? '\$${data.toStringAsFixed(2)}'
                          : 'An Error Occurred',
                      loading: () => 'Loading ...',
                      error: (error, _) => 'An Error Occurred',
                    ),
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                  const SizedBox(height: 20),
                  const BarCode()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarCode extends ConsumerWidget {
  const BarCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The stream is listened to and converted to an AsyncValue.
    final sessionId = ref.watch(authNotifierProvider).sessionId;
    final auth = ref.read(authNotifierProvider.notifier);
    final value = ref.watch(barCodeStream(sessionId));

    // We can use the AsyncValue to handle loading/error states and show the data.
    return value.when(
      data: (data) {
        // if response does not yeild anything, need new session id
        if (data == '') {
          auth.authenticateWithPin();
          return const CircularProgressIndicator();
        }
        final bc = Barcode.pdf417();
        final svg = bc.toSvg(
          data,
        );

        return DecoratedBox(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: AspectRatio(
                aspectRatio: 3 / 1,
                child: ClipRect(
                  child: FractionallySizedBox(
                    heightFactor: 1.8,
                    widthFactor: 0.9,
                    child: SvgPicture.string(
                      svg,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                )),
          ),
        );
      },
      error: (error, _) => Text('Error: $error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
