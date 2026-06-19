import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_swim/state/swimmer_time.dart';
import 'dart:async';

class InputBlock extends StatelessWidget {
  const InputBlock({super.key});

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

class MaxValueFormatter extends TextInputFormatter {
  final num maxValue;

  MaxValueFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final enteredValue = num.tryParse(newValue.text);

    if (enteredValue == null || enteredValue > maxValue) {
      return oldValue;
    }
    return newValue;
  }
}

enum NumberInputType { minutes, seconds }

class NumberInput extends StatefulWidget {
  late final NumberInputType numberInputType;

  NumberInput.minutes({super.key}) {
    numberInputType = NumberInputType.minutes;
  }
  NumberInput.seconds({super.key}) {
    numberInputType = NumberInputType.seconds;
  }

  @override
  State<NumberInput> createState() =>
      // ignore: no_logic_in_create_state
      (NumberInputType.minutes == numberInputType)
      ? NumberInputState.minutes()
      : NumberInputState.seconds();
}

class NumberInputState extends State<NumberInput> {
  NumberInputState.minutes() {
    width = 120;
    maxLength = 1;
    maxValueFormatter = MaxValueFormatter(9);
    onChanged = (String inputText) {};
    numberInputType = NumberInputType.minutes;
  }
  NumberInputState.seconds() {
    width = 150;
    maxLength = 2;
    maxValueFormatter = MaxValueFormatter(59);
    onChanged = _applyNumber;
    numberInputType = NumberInputType.seconds;
  }

  late NumberInputType numberInputType;
  late double width;
  late int maxLength;
  late MaxValueFormatter maxValueFormatter;
  late Function(String)? onChanged;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (NumberInputType.minutes == numberInputType) return;

    _controller.addListener(() {
      String text = _controller.text;

      int? number = int.tryParse(text);

      if (number != null && number >= 0) {
        String paddedText = number.toString().padLeft(2, '0');

        if (paddedText != text) {
          _controller.value = _controller.value.copyWith(
            text: paddedText,
            selection: TextSelection.collapsed(offset: paddedText.length),
          );
        }
      }
    });
  }

  Timer? _timer;

  void _startHolding(VoidCallback onHolding) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      onHolding();
    });
  }

  void _stopHolding() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _applyNumber(String inputText) {
    int? parsedValue = int.tryParse(inputText);
    String formattedText = (parsedValue ?? 0).toString().padLeft(2, '0');

    if (_controller.text != formattedText) {
      _controller.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final swimmerTime = BlocProvider.of<SwimmerTimeCubit>(
      context,
      listen: true,
    );
    if (NumberInputType.minutes == numberInputType) {
      _controller.value = TextEditingValue(
        text: (swimmerTime.state.minutes).toString(),
      );
    }
    if (NumberInputType.seconds == numberInputType) {
      _controller.value = TextEditingValue(
        text: (swimmerTime.state.seconds).toString(),
      );
    }
    return Column(
      children: [
        GestureDetector(
          onLongPressStart: (_) => _startHolding(() {
            if (NumberInputType.minutes == numberInputType) {
              swimmerTime.incrementMinutes();
            }
            if (NumberInputType.seconds == numberInputType) {
              swimmerTime.incrementSeconds();
            }
          }),
          onLongPressEnd: (_) => _stopHolding(),
          onLongPressCancel: () => _stopHolding(),
          child: TextButton(
            onPressed: () {
              if (NumberInputType.minutes == numberInputType) {
                swimmerTime.incrementMinutes();
              }
              if (NumberInputType.seconds == numberInputType) {
                swimmerTime.incrementSeconds();
              }
            },
            child: Icon(Icons.arrow_upward),
          ),
        ),
        SizedBox(
          width: width,
          height: 150,
          child: TextField(
            style: TextStyle(fontSize: 100.0),
            keyboardType: TextInputType.number,
            minLines: 1,
            maxLines: 1,
            maxLength: maxLength,
            showCursor: false,
            textAlign: TextAlign.center,
            onChanged: onChanged,
            controller: _controller,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              maxValueFormatter,
            ],
            decoration: InputDecoration(
              counterText: "",
              hintText: "0",
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        GestureDetector(
          onLongPressStart: (_) => _startHolding(() {
            if (NumberInputType.minutes == numberInputType) {
              swimmerTime.decrementMinutes();
            }
            if (NumberInputType.seconds == numberInputType) {
              swimmerTime.decrementSeconds();
            }
          }),
          onLongPressEnd: (_) => _stopHolding(),
          onLongPressCancel: () => _stopHolding(),
          child: TextButton(
            onPressed: () {
              if (NumberInputType.minutes == numberInputType) {
                swimmerTime.decrementMinutes();
              }
              if (NumberInputType.seconds == numberInputType) {
                swimmerTime.decrementSeconds();
              }
            },
            child: Icon(Icons.arrow_downward),
          ),
        ),
      ],
    );
  }
}
