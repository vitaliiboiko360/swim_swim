import 'package:flutter/material.dart';
import 'package:swim_swim/api/fetch_users.dart';
import 'package:swim_swim/model/user_model.dart';
import 'package:swim_swim/router/router.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(Object context) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        SizedBox(height: 10),
        Text("Users:", style: TextStyle(fontSize: 20)),
        Expanded(child: UserList()),
      ],
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => UserListState();
}

class UserListState extends State<UserList> {
  late Future<List<User>> futureUserList;
  List<User> filteredUserList = [];
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    futureUserList = featchUsers();
  }

  void refetchUsers() async {
    setState(() {
      filteredUserList = [];
      futureUserList = featchUsers();
      isInitialized = false;
    });
    await Future.delayed(const Duration(seconds: 2));
  }

  void applyFilter(String enteredKeyword, List<User> userList) {
    List<User> results = [];
    if (enteredKeyword.isEmpty) {
      results = userList;
    } else {
      results = userList
          .where(
            (item) =>
                item.name.toLowerCase().contains(enteredKeyword.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      filteredUserList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: futureUserList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (!isInitialized) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              applyFilter('', snapshot.data!);
              setState(() {
                isInitialized = true;
              });
            });
          }
          return Column(
            children: [
              Padding(
                padding: .directional(start: 40, end: 40),
                child: TextField(
                  onChanged: (value) => applyFilter(value, snapshot.data!),
                  decoration: const InputDecoration(
                    labelText: 'Filter by name',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                // <-- Wrap your ListView here
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: .vertical,
                  itemCount: filteredUserList.length,
                  padding: .directional(start: 30),
                  itemBuilder: (context, index) {
                    final user = filteredUserList[index];
                    return SizedBox(
                      width: 400,
                      child: ListTile(
                        key: ValueKey(user.id),
                        leading: const Icon(Icons.account_circle),
                        title: Text(user.name),
                        subtitle: UserListItemInfo(
                          email: user.email,
                          phone: user.phone,
                        ),
                        onTap: () {
                          router.push('/users/${user.id}/details', extra: user);
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () {
                  refetchUsers();
                },
                child: Icon(Icons.refresh),
              ),
              SizedBox(height: 30),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class UserListItemInfo extends StatelessWidget {
  const UserListItemInfo({required this.email, required this.phone, super.key});

  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          "Email: $email",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          "Phone: $phone",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
