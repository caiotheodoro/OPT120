import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/layout/index.dart';
import 'package:frontend/settings/keys.dart';
import 'package:frontend/utils/api.dart';
import 'package:http/http.dart' as http;


class UsersPage extends StatefulWidget {
   const UsersPage({super.key, required this.title});

  final String title;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final apiUtils = ApiUtils();


  List<Map<String, dynamic>> users = [];

@override
  void initState() {
    super.initState();
    handleFetchUsers();
  }

  Future<void> handleFetchUsers() async {
    final List<Map<String, dynamic>> users = await apiUtils.fetchUsers();
    setState(() {
      this.users = users;
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: widget.title,
      items: users,
       itemBuilder: (context, item) {
        // Customize how each item is displayed in the list
        return ListTile();
      },
      formFields: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
         Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
      ], onSubmit: () async {
        final url = Uri.parse('http://localhost:3025/users');
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'name': nameController.text,
            'email': emailController.text,
            'password': passwordController.text,
          }),
        );
        if (response.statusCode == 201) {
          handleFetchUsers();
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          RIKeys.usersKey.currentState!.openEndDrawer();
        } else {
          print('deu ruim: ${response.statusCode}');
        }
      },
    );
  }
}