import 'package:flutter/material.dart';
import 'package:frontend/layout/index.dart';
import 'package:frontend/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserActivityPage extends StatefulWidget {
  const UserActivityPage({super.key, required this.title});
  final String title;

  @override
  _UserActivityPageState createState() => _UserActivityPageState();
}

class _UserActivityPageState extends State<UserActivityPage> {

  final apiUtils = ApiUtils();


  Map<String, dynamic>? selectedUser;
  Map<String, dynamic>? selectedActivity;
  
  List<Map<String, dynamic>> userActivities = [];
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> activities = [];

  @override
  void initState() {
    super.initState();
    handleFetchUsers();
    handleFetchActivities();
    handleFetchUserActivities();
  }

  Future<void> handleFetchUsers() async {
    final List<Map<String, dynamic>> users = await apiUtils.fetchUsers();
    setState(() {
      this.users = users;
    });
  }

  Future<void> handleFetchActivities() async {
    final List<Map<String, dynamic>> activities = await apiUtils.fetchActivities();
    setState(() {
      this.activities = activities;
    });
  }

    Future<void> handleFetchUserActivities() async {
    final List<Map<String, dynamic>> userActivities = await apiUtils.fetchUserActivities();
    setState(() {
      this.userActivities = userActivities;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: widget.title,
      items: userActivities,
      itemBuilder: (context, item) {
        return ListTile();
      },
      formFields: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropdownButton(
            hint: const Text('Selecione um usuário'),
            value: selectedUser,
            items: users.map((user) {
              return DropdownMenuItem(
                value: user,
                child: Text(user['name']),
              );
            }).toList(),
            onChanged: (dynamic value) {
              setState(() {
                selectedUser = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropdownButton(
            hint: const Text('Selecione uma atividade'),
            value: selectedActivity,
            items: activities.map((activity) {
              return DropdownMenuItem(
                value: activity,
                child: Text(activity['title']),
              );
            }).toList(),
            onChanged: (dynamic value) {
              setState(() {
                selectedActivity = value;
              });
            },
          ),
        ),
      ],
      onSubmit: () async {
        final url = Uri.parse('http://localhost:3025/user-activities');
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user_id': selectedUser![0]['id'],
          }),
        );
        if (response.statusCode == 201) {
          handleFetchUserActivities();
        } else {
          print('deu ruim: ${response.statusCode}');
        }
      },
    );
  }
}