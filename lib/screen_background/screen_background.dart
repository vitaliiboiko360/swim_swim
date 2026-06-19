import 'package:flutter/material.dart';

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
              width: 400,
              height: 800,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(60)),
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
