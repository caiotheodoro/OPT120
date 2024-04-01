import 'package:flutter/material.dart';
import 'package:frontend/pages/activities.dart';
import 'package:frontend/pages/user-activities.dart';
import 'package:frontend/pages/users.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sidebarx/sidebarx.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usuários',
      initialRoute: '/users',
      theme: ThemeData(
       useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFE0E0E0),
      ),
      home: const UsersPage(title: 'Usuarios'),
      routes: {
        '/users': (context) => const UsersPage(title: 'Usuarios'),
        '/activity': (context) => const ActivitiesPage(title: 'Atividades'),
        '/user-activities': (context) => const UserActivityPage(title: 'Atividades do Usuario'),
      },
    );
  }
}