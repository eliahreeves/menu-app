import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_app/providers/college_list_provider.dart';
import 'package:menu_app/providers/get_mobile_fab_status.dart';
import 'package:menu_app/providers/theme_provider.dart';
import 'package:menu_app/utilities/prefs_service.dart';
import 'package:menu_app/views/nav_drawer.dart';
import '../utilities/constants.dart' as constants;

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPage();
}

// Notice how instead of "State", we are extending "ConsumerState".
// This uses the same principle as "ConsumerWidget" vs "StatelessWidget".
class _SettingsPage extends ConsumerState<SettingsPage> {
  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Material(
          elevation: 5,
          color: Colors.transparent,
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colleges = ref.watch(collegeListProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => context.go('/'),
      child: Scaffold(
        // Displays app heading.
        drawer: const NavDrawer(),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: Text(
            "Settings",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: constants.menuHeadingSize,
                fontFamily: 'Monoton',
                color: Theme.of(context).colorScheme.primary),
          ),
          toolbarHeight: 60,
          centerTitle: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: Border(
              bottom: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 4)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 7, 14, 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Layout",
                        style: TextStyle(
                          fontFamily: constants.titleFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Color(constants.titleColor),
                        ),
                      ),
                      const Text(
                        "Drag to reorder home screen.",
                        style: TextStyle(
                          fontFamily: constants.titleFont,
                          fontSize: 15,
                          color: Color(constants.subTitleColor),
                          height: constants.titleFontheight,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        onReorder:
                            ref.read(collegeListProvider.notifier).reorderData,
                        itemCount: colleges.length,
                        proxyDecorator: proxyDecorator,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            key: ValueKey(colleges[index].id),
                            child: ReorderableDragStartListener(
                              index: index,
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 51, 51, 51),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: SizedBox(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Icon(
                                          LucideIcons.menu,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                      Text(
                                        colleges[index].name,
                                        style: TextStyle(
                                          fontFamily: constants.titleFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: constants.titleFontSize,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          height: constants.titleFontheight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const _SecuritySettings(),
              const SizedBox(
                height: 10,
              ),
              const ThemeSettings(),
              const SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeSettings extends ConsumerStatefulWidget {
  const ThemeSettings({super.key});

  @override
  ConsumerState<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends ConsumerState<ThemeSettings> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);
    final getMobileFabStatus = ref.watch(getMobileFabStatusProvider);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 7, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Appearance",
              style: TextStyle(
                fontFamily: constants.titleFont,
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Color(constants.titleColor),
              ),
            ),
            const Text(
              "Change look and colors.",
              style: TextStyle(
                fontFamily: constants.titleFont,
                fontSize: 15,
                color: Color(constants.subTitleColor),
                height: constants.titleFontheight,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(LucideIcons.scan_barcode),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  "Show GET Button",
                  style: TextStyle(
                    fontFamily: constants.titleFont,
                    fontSize: 18,
                    color: Color(constants.titleColor),
                    height: constants.titleFontheight,
                  ),
                ),
                const Spacer(),
                CupertinoSwitch(
                    value: getMobileFabStatus,
                    onChanged: (val) => ref
                        .read(getMobileFabStatusProvider.notifier)
                        .setBool(val))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(LucideIcons.palette),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  "Default Theme",
                  style: TextStyle(
                    fontFamily: constants.titleFont,
                    fontSize: 18,
                    color: Color(constants.titleColor),
                    height: constants.titleFontheight,
                  ),
                ),
                const Spacer(),
                CupertinoSwitch(
                    value: theme.isDefault,
                    onChanged: (val) => ref
                        .read(themeNotifierProvider.notifier)
                        .updateTheme(isDefault: val))
              ],
            ),
            if (!theme.isDefault)
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Primary Color",
                        style: TextStyle(
                          fontFamily: constants.titleFont,
                          fontSize: 18,
                          color: Color(constants.titleColor),
                          height: constants.titleFontheight,
                        ),
                      ),
                      _ColorPickerDisplay(
                          color: Theme.of(context).colorScheme.primary,
                          setColor: (color) => ref
                              .read(themeNotifierProvider.notifier)
                              .updateTheme(otherPrimary: color))
                    ],
                  )),
            if (!theme.isDefault)
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Secondary Color",
                        style: TextStyle(
                          fontFamily: constants.titleFont,
                          fontSize: 18,
                          color: Color(constants.titleColor),
                          height: constants.titleFontheight,
                        ),
                      ),
                      _ColorPickerDisplay(
                          color: Theme.of(context).colorScheme.secondary,
                          setColor: (color) => ref
                              .read(themeNotifierProvider.notifier)
                              .updateTheme(otherSecondary: color)),
                    ],
                  )),
          ],
        ),
      ),
    );
  }
}

class _ColorPickerDisplay extends ConsumerStatefulWidget {
  const _ColorPickerDisplay({required this.color, required this.setColor});
  final Color color;
  final void Function(Color) setColor;
  @override
  ConsumerState<_ColorPickerDisplay> createState() =>
      __ColorPickerDisplayState();
}

class __ColorPickerDisplayState extends ConsumerState<_ColorPickerDisplay> {
  Color? pendingColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (ref.read(themeNotifierProvider).isDefault) {
          return;
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Pick a color"),
            content: ColorPicker(
              pickerColor: widget.color,
              onColorChanged: (color) {
                pendingColor = color;
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (pendingColor != null) {
                    widget.setColor(pendingColor!);
                  }
                  Navigator.pop(context);
                },
                child: const Text("Select"),
              ),
            ],
          ),
        );
      },
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text("#${widget.color.toHexString()}"),
          ),
          Container(
            width: 25,
            height: 25,
            color: widget.color,
          ),
        ],
      ),
    );
  }
}

class _SecuritySettings extends ConsumerStatefulWidget {
  const _SecuritySettings();

  @override
  ConsumerState<_SecuritySettings> createState() => __SecuritySettingsState();
}

class __SecuritySettingsState extends ConsumerState<_SecuritySettings> {
  final pref = PrefsService.instance;
  late int selected;
  late bool getBioAuthEnabled;
  @override
  void initState() {
    super.initState();
    getBioAuthEnabled = pref.getBool('get_bio_auth_enabled') ?? constants.enableBiometric;
    selected = pref.getInt('get_pin_timeout_allowed') ??
        constants.defaultGetPinAllowedSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 7, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Security",
              style: TextStyle(
                fontFamily: constants.titleFont,
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Color(constants.titleColor),
              ),
            ),
            const Text(
              "Change GET authentication settings.",
              style: TextStyle(
                fontFamily: constants.titleFont,
                fontSize: 15,
                color: Color(constants.subTitleColor),
                height: constants.titleFontheight,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(LucideIcons.lock_open),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  "GET PIN Timeout",
                  style: TextStyle(
                    fontFamily: constants.titleFont,
                    fontSize: 18,
                    color: Color(constants.titleColor),
                    height: constants.titleFontheight,
                  ),
                ),
                const Spacer(),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 51, 51, 51),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: selected,
                        items: constants.GetPinAllowedOptions.values
                            .map((item) => DropdownMenuItem(
                                value: item.seconds, child: Text(item.name)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            pref.setInt('get_pin_timeout_allowed', val);
                          }
                          setState(() {
                            selected =
                                val ?? constants.defaultGetPinAllowedSeconds;
                          });
                        },
                        style: TextStyle(
                          fontFamily: constants.titleFont,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        dropdownColor: const Color.fromARGB(255, 51, 51, 51),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(LucideIcons.fingerprint),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  "Enable Biometrics",
                  style: TextStyle(
                    fontFamily: constants.titleFont,
                    fontSize: 18,
                    color: Color(constants.titleColor),
                    height: constants.titleFontheight,
                  ),
                ),
                const Spacer(),
                CupertinoSwitch(
                    value: getBioAuthEnabled,
                    onChanged: (val) {
                      final prefs = PrefsService.instance;
                      setState(() {
                        getBioAuthEnabled = val;
                      });
                      prefs.setBool('get_bio_auth_enabled', val);
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
