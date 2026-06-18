import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swim_swim/main.dart';

class SwimerApp extends StatelessWidget {
  const SwimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swimmer App Demo',
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
        children: [
          InputBlock(),
          CategorySwimer(),
          CategorySlider(),
          SubmitButtons(),
        ],
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
                NumberInput.minutes(),
                Text(':', style: TextStyle(fontSize: 100)),
                NumberInput.seconds(),
              ],
            ),
            Row(
              children: [
                Text('MIN : SEC / 100M', style: TextStyle(fontSize: 12)),
              ],
            ),
            SizedBox(height: 25),
          ],
        ),
      ],
    );
  }
}

class NumberInput extends StatelessWidget {
  NumberInput.minutes({super.key}) {
    width = 120;
    maxLength = 1;
  }
  NumberInput.seconds({super.key}) {
    width = 150;
    maxLength = 2;
  }

  late double width;
  late int maxLength;

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
          width: width,
          height: 150,
          child: TextField(
            style: TextStyle(fontSize: 100.0),
            keyboardType: TextInputType.number, // Opens the numeric keypad
            minLines: 1,
            maxLines: 1,
            maxLength: maxLength,
            showCursor: false,
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

class CategorySwimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Column(
          children: [
            SizedBox(height: 5),
            Text(
              "fits to swimming level:".toUpperCase(),
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            Text(
              "CATEGORY",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class CategorySlider extends StatefulWidget {
  const CategorySlider({super.key});

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

enum SwimmerCategory { elite, advanced, normal, beginner }

Color getCategoryColor(SwimmerCategory swimmerCategory) {
  switch (swimmerCategory) {
    case SwimmerCategory.elite:
      return Colors.orange;
    case SwimmerCategory.advanced:
      return Colors.lightGreen;
    case SwimmerCategory.normal:
      return Colors.lightBlueAccent;
    case SwimmerCategory.beginner:
      return Colors.grey;
  }
}

class SliderCategory extends StatelessWidget {
  SliderCategory(this.swimmerCategory, this.value, this.onChanged, {super.key});
  SwimmerCategory swimmerCategory;
  double value;
  ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: .center,
        spacing: 20,
        children: [
          Text(
            swimmerCategory.name.toUpperCase(),
            style: TextStyle(
              fontSize: onChanged == null ? 10 : 14,
              fontWeight: onChanged == null ? .normal : .bold,
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: onChanged == null
                  ? SliderComponentShape.noThumb
                  : RoundSliderThumbShape(),
              thumbColor: getCategoryColor(swimmerCategory),
              overlayShape: SliderComponentShape.noOverlay,
              activeTrackColor: getCategoryColor(swimmerCategory),
              inactiveTrackColor: getCategoryColor(swimmerCategory),
              trackHeight: 5.0,
              trackShape: RectangularSliderTrackShape(),
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
              padding: onChanged == null
                  ? EdgeInsetsGeometry.directional(
                      start: 0,
                      end: 0,
                      top: 12,
                      bottom: 6,
                    )
                  : EdgeInsetsGeometry.zero,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategorySliderState extends State<CategorySlider> {
  double _firstSlider = 1;
  double _secondSlider = 1;
  double _thirdSlider = 1;
  double _forthSlider = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.directional(
        start: 40,
        end: 40,
        top: 20,
        bottom: 20,
      ),
      child: Column(
        children: [
          Row(
            spacing: 0,
            children: <Widget>[
              SliderCategory(
                SwimmerCategory.elite,
                _firstSlider,
                null,
                // (double value,) {
                //   setState(() {
                //     _firstSlider = value;
                //   });
                // },
              ),
              SliderCategory(
                SwimmerCategory.advanced,
                _secondSlider,
                // null,
                (double value) {
                  setState(() {
                    _secondSlider = value;
                  });
                },
              ),
              SliderCategory(
                SwimmerCategory.normal,
                _thirdSlider,
                null,
                // (double value) {
                //   setState(() {
                //     _thirdSlider = value;
                //   });
                // },
              ),
              SliderCategory(
                SwimmerCategory.beginner,
                _forthSlider,
                null,
                // (double value) {
                //   setState(() {
                //     _forthSlider = value;
                //   });
                // },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(child: SizedBox.shrink()),
              Expanded(child: Text('1:00')),
              Expanded(child: Text('1:30')),
              Expanded(child: Text('2:00')),
            ],
          ),
        ],
      ),
    );
  }
}

class SubmitButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.directional(top: 20),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Column(
            spacing: 10,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                  foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                onPressed: () {},
                child: Padding(
                  padding: .all(20),
                  child: Row(
                    spacing: 10,
                    children: [
                      Text(
                        "continue".toUpperCase(),
                        style: TextStyle(fontSize: 20, fontWeight: .bold),
                      ),
                      Icon(Icons.arrow_forward, size: 20, fontWeight: .bold),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Padding(
                  padding: .all(5),
                  child: Text("skip".toUpperCase()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
