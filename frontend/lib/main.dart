import 'package:flutter/material.dart';
import 'package:frontend/pages/activities.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/user-activities.dart';
import 'package:frontend/pages/users.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  Future<String> fetchAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token') ?? '';

    return token;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            title: 'Usuários',
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          final String accessToken = snapshot.data ?? '';
          final String initialRoute = accessToken.isEmpty ? '/users' : '/login';

          return MaterialApp(
            title: 'Usuários',
            initialRoute: initialRoute,
            onGenerateRoute: (settings) {
              if (settings.name == '/activity') {
                return MaterialPageRoute(builder: (context) => const ActivitiesPage(title: 'Atividades'));
              }
              return null;
            },
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: const Color(0xFFE0E0E0),
            ),
            home: accessToken.isNotEmpty ? const UsersPage(title: 'Usuários') : const LoginPage(title: 'Login'),
            routes: {
              '/login': (context) => const LoginPage(title: 'Login'), 
              '/users': (context) => const UsersPage(title: 'Usuarios'),
              '/user-activities': (context) =>
                  const UserActivityPage(title: 'Atividades do Usuario'),
            },
          );
        }
      },
    );
  }
}
