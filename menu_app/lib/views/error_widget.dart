import 'package:flutter/material.dart';

OverlayEntry? _overlayEntry;

void showOverlay(BuildContext context) {
  _overlayEntry = OverlayEntry(
    builder: (context) => AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: 1.0,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: -20,
                right: 20,
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: Image.asset(
                    'icons/error.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 300,
                right: 200,
                child: Stack(
                  // alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        'icons/speech.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                        width: 150,
                        height: 120,
                        child: Center(
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              "There hath been an error!",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(_overlayEntry!);
  Future.delayed(const Duration(seconds: 2), () {
    _overlayEntry?.remove();
    _overlayEntry = null;
  });
}
