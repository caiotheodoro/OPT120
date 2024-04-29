import 'package:flutter/material.dart';
import 'package:frontend/utils/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final loginApiHelper = LoginApiHelper();

  @override
  //login page with a centered modal, email and password fields, and a login button. the modal is white and the inputs is a light grey and border radius of 8
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          height: 300,
  
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), // Add border radius here
            color: Colors.white,

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ElevatedButton(
                  onPressed: () async {
                    // Add a pushReplacementNamed method to the onPressed event
                    final res = await loginApiHelper.login(emailController.text, passwordController.text);

                    if (res['access_token'] != null) {
                      Navigator.pushReplacementNamed(context, '/users');
                    }
                    // Navigator.pushReplacementNamed(context, '/users');
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}