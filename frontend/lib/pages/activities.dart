
import 'package:flutter/material.dart';
import 'package:frontend/layout/index.dart';
import 'package:frontend/utils/activity.dart';
import 'package:intl/intl.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key, required this.title});
  final String title;

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  String? id = '';
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final activityApiHelper = ActivityApiHelper();

  List<Map<String, dynamic>> activities = [];
  dynamic selectedDate;

  @override
  void initState() {
    super.initState();
    this.activities = [];
    handleFetchActivities();
  }

  Future<void> handleFetchActivities() async {
    final List<Map<String, dynamic>> activities =
        await activityApiHelper.fetchActivities();
    setState(() {
      this.activities = activities;
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
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    handleFetchActivities();
    id = '';
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: widget.title,
      items: activities,
      itemBuilder: (context, item) {
        return ListTile();
      },
      formFields: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Titulo',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descrição',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            controller: dateController,
            decoration: const InputDecoration(
              labelText: 'Selecionar Data',
              border: OutlineInputBorder(),
            ),
            onTap: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(height: 8.0),
      ],
      onSubmit: () async {
        await activityApiHelper.createActivity(
          id,
          titleController.text,
          descriptionController.text,
          selectedDate,
        );
        handleClearFields();
      },
      onDelete: (id) async  {
        await activityApiHelper.deleteActivity(id);
        handleClearFields();
      },
      onEdit: (id) async {
        final activity = await activityApiHelper.fetchActivity(id);
        titleController.text = activity['title'];
        descriptionController.text = activity['description'];
        dateController.text = activity['date'];
        this.id = id.toString();
      },
    );
  }
}
