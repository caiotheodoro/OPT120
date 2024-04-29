import 'package:flutter/material.dart';
import 'package:frontend/layout/index.dart';
import 'package:frontend/utils/activity.dart';
import 'package:frontend/utils/user-activity.dart';
import 'package:frontend/utils/user.dart';

import 'package:intl/intl.dart';

class UserActivityPage extends StatefulWidget {
  const UserActivityPage({super.key, required this.title});
  final String title;

  @override
  _UserActivityPageState createState() => _UserActivityPageState();
}

class _UserActivityPageState extends State<UserActivityPage> {
  String? id = '';
  final userActivityApiHelper = UserActivityApiHelper();
  final userApiHelper = UserApiHelper();
  final activityApiHelper = ActivityApiHelper();
  final dateController = TextEditingController();
  final gradeController = TextEditingController();

  Map<String, dynamic>? selectedUser;
  Map<String, dynamic>? selectedActivity;

  List<Map<String, dynamic>> userActivities = [];
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> activities = [];

  dynamic selectedDate;

  @override
  void initState() {
    super.initState();
    handleFetchUsers();
    handleFetchActivities();
    handleFetchUserActivities();
  }

  Future<void> handleFetchUsers() async {
    final List<Map<String, dynamic>> users = await userApiHelper.fetchUsers();
    setState(() {
      this.users = users;
    });
  }

  Future<void> handleFetchActivities() async {
    final List<Map<String, dynamic>> activities =
        await activityApiHelper.fetchActivities();
    setState(() {
      this.activities = activities;
    });
  }

  Future<void> handleFetchUserActivities() async {
    final List<Map<String, dynamic>> userActivities =
        await userActivityApiHelper.fetchUserActivities();
    setState(() {
      this.userActivities = userActivities;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      dateController.text =
          DateFormat('dd/MM/yyyy').format(pickedDate).toString();
      setState(() {
        this.selectedDate =
            DateTime.parse(pickedDate.toString()).toIso8601String();
      });
    }
  }

      Future<void> handleClearFields() async {
      dateController.clear();
      gradeController.clear();
      selectedUser = null;
      selectedActivity = null;
      id = '';
      handleFetchUserActivities();
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
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            controller: dateController,
            decoration: const InputDecoration(
              labelText: 'Data de entrega',
              border: OutlineInputBorder(),
            ),
            onTap: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            controller: gradeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nota',
              border: OutlineInputBorder(),
            ),
          ),
        )
      ],
      onSubmit: () async {
       await userActivityApiHelper.createUserActivity(
          id,
          selectedUser!['id'],
          selectedActivity!['id'],
          selectedDate,
          int.parse(gradeController.text),
        );
        handleClearFields();
      },
      onDelete: (id) async {
        await userActivityApiHelper.deleteUserActivity(id);
        handleClearFields();
      },
       onEdit: (id) async {
      },
    );
  }
}
