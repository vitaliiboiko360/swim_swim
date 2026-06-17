import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swim_swim/main.dart';

class SwimerApp extends StatelessWidget {
  const SwimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swimmer App Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 108, 158, 245),
          brightness:
              Brightness.dark, // Crucial for calculating dark mode tones
        ),
      ),
      home: const ScreenBackground(),
    );
  }
}

class ScreenBackground extends StatefulWidget {
  const ScreenBackground({super.key});

  @override
  State<ScreenBackground> createState() => _ScreenBackgroundState();
}

class _ScreenBackgroundState extends State<ScreenBackground> {
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
                child: InputScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(Object context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [InputBlock()],
      ),
    );
  }
}

class InputBlock extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              children: [
                NumberInput(),
                Text(':', style: TextStyle(fontSize: 100)),
                NumberInput(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class NumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            print('up');
          },
          child: Icon(Icons.arrow_upward),
        ),
        SizedBox(
          width: 150,
          height: 150,
          child: TextField(
            style: TextStyle(fontSize: 100.0),
            keyboardType: TextInputType.number, // Opens the numeric keypad
            minLines: 1,
            maxLines: 1,
            maxLength: 1,
            textAlign: TextAlign.center,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              counterText: "",
              hintText: "0",
              isDense: true, // Reduces default material padding
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ), // Custom internal spacing
              border: OutlineInputBorder(),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            print('down');
          },
          child: Icon(Icons.arrow_downward),
        ),
      ],
    );
  }
}
