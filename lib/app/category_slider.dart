import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_swim/app/category_swimer.dart';
import 'package:swim_swim/state/swimmer_time.dart';

const double sliderMax = 10;

double getSliderValue(int seconds) {
  if (seconds <= 60) return seconds * (2 / 60);
  if (seconds <= 90) return seconds * (4 / 90);
  if (seconds <= 120) return seconds * (6 / 120);
  return (seconds * (4 / 480)) + 5;
}

int getSliderTime(double sliderValue) {
  if (sliderValue <= 2) return (sliderValue * (60 / 2)).toInt();
  if (sliderValue <= 4) return (sliderValue * (90 / 4)).toInt();
  if (sliderValue <= 6) return (sliderValue * (120 / 6)).toInt();
  return ((min(sliderValue, 9.99) - 6) * (480 / 4)).round() + 120;
}

class CategorySlider extends StatefulWidget {
  const CategorySlider({super.key});

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class SliderCategory extends StatefulWidget {
  const SliderCategory(this.swimmerCategory, this.onChangedState, {super.key});
  final SwimmerCategory swimmerCategory;
  final ValueChanged<double> onChangedState;

  @override
  State<SliderCategory> createState() =>
      // ignore: no_logic_in_create_state
      SliderCategoryState(swimmerCategory, onChangedState);
}

class SliderCategoryState extends State<SliderCategory> {
  SliderCategoryState(this.swimmerCategory, this.onChangedState);
  SwimmerCategory swimmerCategory;
  double sliderValue = 0;
  ValueChanged<double> onChangedState;
  bool isSliderUpdating = false;

  @override
  Widget build(BuildContext context) {
    final swimmerTime = BlocProvider.of<SwimmerTimeCubit>(
      context,
      listen: true,
    );
    setState(() {
      if (isSliderUpdating) {
        isSliderUpdating = false;
        return;
      }
      sliderValue = getSliderValue(swimmerTime.state.getTotalSeconds());
      swimmerCategory = getCategory(sliderValue);
    });
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: RoundSliderThumbShape(),
        thumbColor: getCategoryColor(swimmerCategory),
        overlayShape: SliderComponentShape.noOverlay,
        activeTrackColor: getCategoryColor(swimmerCategory),
        inactiveTrackColor: getCategoryColor(swimmerCategory),
        trackHeight: 5.0,
        trackShape: RectangularSliderTrackShape(),
      ),
      child: Slider(
        value: sliderValue,
        onChanged: (double updatedValue) {
          setState(() {
            sliderValue = updatedValue;
            swimmerCategory = getCategory(sliderValue);
            int totalSeconds = getSliderTime(sliderValue);
            isSliderUpdating = true;
            swimmerTime.updateTime(totalSeconds ~/ 60, totalSeconds % 60);
          });
          onChangedState(sliderValue);
        },
        min: 0,
        max: sliderMax,
      ),
    );
  }
}

class CategoryLabel extends StatelessWidget {
  const CategoryLabel(this.swimmerCategory, this.isActive, {super.key});
  final SwimmerCategory swimmerCategory;
  final bool isActive;
  @override
  Widget build(Object context) {
    return Expanded(
      flex: getCategoryFlex(swimmerCategory),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          Text(
            swimmerCategory.name.toUpperCase(),
            style: TextStyle(
              fontSize: isActive ? 11 : 9,
              fontWeight: isActive ? .bold : .normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategorySliderState extends State<CategorySlider> {
  SwimmerCategory swimmerCategory = SwimmerCategory.beginner;

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
          Padding(
            padding: .directional(start: 20),
            child: Row(
              children: [
                CategoryLabel(
                  SwimmerCategory.elite,
                  SwimmerCategory.elite == swimmerCategory,
                ),
                CategoryLabel(
                  SwimmerCategory.advanced,
                  SwimmerCategory.advanced == swimmerCategory,
                ),
                CategoryLabel(
                  SwimmerCategory.middle,
                  SwimmerCategory.middle == swimmerCategory,
                ),
                CategoryLabel(
                  SwimmerCategory.beginner,
                  SwimmerCategory.beginner == swimmerCategory,
                ),
              ],
            ),
          ),
          SliderCategory(swimmerCategory, (double value) {
            setState(() {
              swimmerCategory = getCategory(value);
            });
          }),
          Row(
            children: [
              Expanded(flex: 2, child: SizedBox.shrink()),
              Expanded(flex: 2, child: Text('1:00')),
              Expanded(flex: 2, child: Text('1:30')),
              Expanded(flex: 4, child: Text('2:00')),
            ],
          ),
        ],
      ),
    );
  }
}
