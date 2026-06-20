import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_swim/model/user_model.dart';
import 'package:swim_swim/app/input_screen.dart';
import 'package:swim_swim/screen_background/screen_background.dart';
import 'package:swim_swim/users/user_details.dart';
import 'package:swim_swim/users/users.dart';

final GoRouter router = GoRouter(
  errorBuilder: (BuildContext context, GoRouterState state) {
    return MaterialApp(
      title: 'ERROR BUILDER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 243, 5, 5),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 20.0,
            color: Color.fromARGB(255, 245, 11, 11),
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: ScreenBackground(child: InputScreen()),
    );
  },
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return ScreenBackground(child: InputScreen());
      },
    ),
    GoRoute(
      path: '/users',
      builder: (BuildContext context, GoRouterState state) {
        return ScreenBackground(child: UsersScreen());
      },
      routes: [
        GoRoute(
          path: '/:userId/details',
          builder: (BuildContext context, GoRouterState state) {
            final user = state.extra as User;
            return ScreenBackground(child: UsersDetailsScreen(user: user));
          },
        ),
      ],
    ),
  ],
);
