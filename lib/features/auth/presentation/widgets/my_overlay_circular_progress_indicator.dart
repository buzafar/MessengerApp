import 'package:flutter/material.dart';


class MyOverlayCircularProgressIndicator {
  final BuildContext context;
  final OverlayState overlay;
  final OverlayEntry overlayEntry;

  MyOverlayCircularProgressIndicator._(this.context, this.overlay, this.overlayEntry);

  factory MyOverlayCircularProgressIndicator(BuildContext newContext) {
    final overlay = Overlay.of(newContext);

    final overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            // Dimmed background
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            // Centered loader
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        )
    );
    return MyOverlayCircularProgressIndicator._(newContext, overlay, overlayEntry);
  }

  void show() {
    overlay.insert(overlayEntry);
  }

  void close() {
    overlayEntry.remove();
  }
}