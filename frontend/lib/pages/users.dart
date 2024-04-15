
import 'package:flutter/material.dart';
import 'package:frontend/layout/index.dart';
import 'package:frontend/utils/user.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key, required this.title});

  final String title;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String? id = '';
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userApiHelper = UserApiHelper();

  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    this.users = [];
    handleFetchUsers();
  }

  Future<void> handleFetchUsers() async {
    final List<Map<String, dynamic>> users = await userApiHelper.fetchUsers();
    setState(() {
      this.users = users;
    });
  }

   Future<void> handleClearFields() async {
     // Add a return statement at the end of the function
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      id = '';
      await handleFetchUsers();
   }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      pageTitle: widget.title,
      items: users ?? [],
      itemBuilder: (context, item) {
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
      ],
      onSubmit: () async {
        await userApiHelper.createUser(
            id,
          nameController.text,
          emailController.text,
          passwordController.text,
        );
         handleClearFields();
      },
      onDelete: (id) async {
        await userApiHelper.deleteUser(id);
        handleClearFields();
      },
       onEdit: (id) async {
        final user = await userApiHelper.fetchUser(id);
        //set the info to the form fields and open the drawer
        nameController.text = user['name'];
        emailController.text = user['email'];
        passwordController.text = user['password'];
        this.id = id.toString();

      
      },
    );
  }
}
