import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:swim_swim/app/swimmer_app.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const SwimmerApp());
}
