import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_swim/app/category_slider.dart';
import 'package:swim_swim/state/swimmer_time.dart';

enum SwimmerCategory { elite, advanced, middle, beginner }

SwimmerCategory getCategory(double sliderValue) {
  if (sliderValue <= 2) return SwimmerCategory.elite;
  if (sliderValue <= 4) return SwimmerCategory.advanced;
  if (sliderValue <= 6) return SwimmerCategory.middle;
  return SwimmerCategory.beginner;
}

Color getCategoryColor(SwimmerCategory swimmerCategory) {
  switch (swimmerCategory) {
    case SwimmerCategory.elite:
      return Colors.orange;
    case SwimmerCategory.advanced:
      return Colors.lightGreen;
    case SwimmerCategory.middle:
      return Colors.lightBlueAccent;
    case SwimmerCategory.beginner:
      return Colors.grey;
  }
}

int getCategoryFlex(SwimmerCategory swimmerCategory) {
  switch (swimmerCategory) {
    case SwimmerCategory.elite:
      return 2;
    case SwimmerCategory.advanced:
      return 2;
    case SwimmerCategory.middle:
      return 2;
    case SwimmerCategory.beginner:
      return 4;
  }
}

class CategorySwimer extends StatelessWidget {
  const CategorySwimer({super.key});

  @override
  Widget build(BuildContext context) {
    final swimmerTime = BlocProvider.of<SwimmerTimeCubit>(
      context,
      listen: true,
    );
    return Row(
      mainAxisAlignment: .center,
      children: [
        Column(
          children: [
            SizedBox(height: 5),
            Text(
              "fit to swimming level:".toUpperCase(),
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            Text(
              getCategory(
                getSliderValue(swimmerTime.state.getTotalSeconds()),
              ).name.toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: getCategoryColor(
                  getCategory(
                    getSliderValue(swimmerTime.state.getTotalSeconds()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
