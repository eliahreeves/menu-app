import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menu_app/custom_widgets/key_pad.dart';

class CreatePinDialog extends ConsumerStatefulWidget {
  const CreatePinDialog({super.key});

  @override
  ConsumerState<CreatePinDialog> createState() => _CreatePinDialogState();
}

class _CreatePinDialogState extends ConsumerState<CreatePinDialog> {
  final controller = TextEditingController();
  String firstPin = '';
  bool onPinComplete(String pin) {
    if (firstPin == '') {
      setState(() {
        firstPin = pin;
      });
      return true;
    } else {
      if (pin == firstPin) {
        Navigator.of(context).pop(pin);
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    if (firstPin == '') {
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        firstPin = '';
                        controller.clear();
                      });
                    }
                  },
                  icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          firstPin == ''
                              ? LucideIcons.x
                              : Icons.arrow_back_ios_new,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Text(firstPin == '' ? "Cancel" : "Back"),
                      ]),
                ),
              ),
              const Spacer(),
              Text(firstPin == '' ? "Enter a PIN" : "Confirm PIN"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: KeyPad(
                  controller: controller,
                  onFull: onPinComplete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
