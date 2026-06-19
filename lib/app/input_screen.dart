import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_swim/app/category_slider.dart';
import 'package:swim_swim/app/category_swimer.dart';
import 'package:swim_swim/app/input_block.dart';
import 'package:swim_swim/app/submit_buttons_group.dart';
import 'package:swim_swim/state/swimmer_time.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(Object context) {
    return SizedBox.expand(
      child: BlocProvider(
        lazy: false,
        create: (BuildContext context) => SwimmerTimeCubit(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputBlock(),
            CategorySwimer(),
            CategorySlider(),
            SubmitButtonsGroup(),
          ],
        ),
      ),
    );
  }
}
