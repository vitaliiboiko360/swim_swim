import 'package:flutter/material.dart';
import 'package:swim_swim/model/user_model.dart';
import 'package:swim_swim/router/router.dart';

class UsersDetailsScreen extends StatelessWidget {
  const UsersDetailsScreen({required this.user, super.key});

  final User user;

  @override
  Widget build(Object context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: .start,
          children: [
            SizedBox(width: 25),
            FloatingActionButton(
              onPressed: () {
                router.push('/users');
              },
              child: Icon(Icons.arrow_back),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text("User Id: ${user.id}", style: TextStyle(fontSize: 20)),
        SizedBox(height: 20),
        UserAdditionalInfo(user: user),
      ],
    );
  }
}

class UserAdditionalInfo extends StatelessWidget {
  const UserAdditionalInfo({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        DefaultTextStyle(
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Column(
            crossAxisAlignment: .end,
            spacing: 10,
            children: [
              Text("Name: "),
              Text("Email: "),
              Text("Phone: "),
              Text("Website: "),
              Text("Company: "),
            ],
          ),
        ),
        DefaultTextStyle(
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 10,
            children: [
              Text(user.name),
              Text(user.email),
              Text(user.phone),
              Text(user.website),
              Text(user.company.name),
            ],
          ),
        ),
      ],
    );
  }
}
