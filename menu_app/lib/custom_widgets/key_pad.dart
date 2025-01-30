import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:vibration/vibration.dart';

void vibrate() async {
  if(Platform.isIOS){
    HapticFeedback.selectionClick();
    return;
  }
  if (await Vibration.hasVibrator() ?? false) {
    if (await Vibration.hasCustomVibrationsSupport() ?? false) {
      Vibration.vibrate(duration: 100, amplitude: 1);
    }
  }
}

class KeyPad extends StatefulWidget {
  const KeyPad({super.key, required this.controller, required this.onFull});
  final TextEditingController controller;
  final bool Function(String) onFull;

  @override
  State<KeyPad> createState() => _KeyPadState();
}

class _KeyPadState extends State<KeyPad> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,

    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0.0),
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _shake() {
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SlideTransition(
          position: _offsetAnimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              final icon = index < widget.controller.text.length
                  ? Icons.circle
                  : Icons.circle_outlined;
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Icon(icon, color: Theme.of(context).colorScheme.secondary));
            }),
          ),
        ),
      ),
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(
          12, // Change to 12 to include empty spaces
          (index) {
            if (index == 9) {
              return const AspectRatio(
                aspectRatio: 1,
                child: SizedBox(), // Empty container for spacing
              );
            } else if (index == 11) {
              return AspectRatio(
                aspectRatio: 1,
                child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      //HapticFeedback.selectionClick();
                       vibrate();
                      if (widget.controller.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        widget.controller.text = widget.controller.text
                            .substring(0, widget.controller.text.length - 1);
                      });
                    },
                    child: const Icon(
                      LucideIcons.delete,
                      size: 40,
                    )),
              );
            } else {
              final value = index == 10 ? 0 : index + 1;
              return AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary),
                        shape: BoxShape.circle),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        // HapticFeedback.selectionClick();
                         vibrate();
                        if (widget.controller.text.length >= 4) {
                          widget.controller.clear();
                          return;
                        }
                        setState(() {
                          widget.controller.text += '$value';
                        });
                        if (widget.controller.text.length >= 4) {
                          bool isFull = widget.onFull(widget.controller.text);
                          if (!isFull) {
                            _shake();
                          }
                          widget.controller.clear();
                        }
                      },
                      child: Center(
                        child: Text(
                          '$value',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      )
    ]);
  }
}
