import 'package:flutter/material.dart';
import 'package:swim_swim/router/router.dart';

class SwimmerApp extends StatelessWidget {
  const SwimmerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Swimmer App Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 108, 158, 245),
          brightness:
              Brightness.dark, // Crucial for calculating dark mode tones
        ),
      ),
      routerConfig: router,
    );
  }
}
