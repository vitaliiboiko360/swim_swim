import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_swim/api/send_time.dart';
import 'package:swim_swim/loading.dart';
import 'package:swim_swim/state/swimmer_time.dart';

class SubmitButtonsGroup extends StatefulWidget {
  const SubmitButtonsGroup({super.key});

  @override
  State<SubmitButtonsGroup> createState() => _SubmitButtonsGroupState();
}

class _SubmitButtonsGroupState extends State<SubmitButtonsGroup> {
  @override
  Widget build(BuildContext context) {
    final swimmerTime = BlocProvider.of<SwimmerTimeCubit>(
      context,
      listen: true,
    );
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
                onPressed: () async {
                  LoadingScreen.instance().show(context: context);
                  String outputMessage = '';
                  String errorText = '';
                  outputMessage =
                      await sendTime(
                        swimmerTime.state.getTotalSeconds(),
                      ).catchError((error) {
                        errorText = error;
                        return error;
                      });
                  await Future.delayed(const Duration(seconds: 1));
                  if (context.mounted) {
                    LoadingScreen.instance().show(
                      context: context,
                      text: errorText.isEmpty
                          ? "Updated: in seconds $outputMessage"
                          : "Not updated: $errorText",
                    );
                  }
                  await Future.delayed(const Duration(seconds: 1));
                  LoadingScreen.instance().hide();
                },
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
