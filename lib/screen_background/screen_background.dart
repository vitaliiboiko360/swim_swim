import 'package:flutter/material.dart';

const double screenWidth = 400;
const double screenHeight = 800;
const double screenBorderRadius = 60;

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: .all(.circular(screenBorderRadius)),
                  color: Theme.of(context).colorScheme.surfaceBright,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
