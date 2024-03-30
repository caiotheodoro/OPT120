import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sidebarx/sidebarx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usuários',
      initialRoute: '/users',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UsersPage(title: 'Usuarios'),
      routes: {
        '/users': (context) => const UsersPage(title: 'Usuarios'),
        '/activity': (context) => const UsersPage(title: 'Activity'),
      },
    );
  }
}

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final url = Uri.parse('http://localhost:3025/users');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      final List<Map<String, dynamic>> users =
          responseBody.map((user) => user as Map<String, dynamic>).toList();
      setState(() {
        this.users = users;
      });
    } else {
      print('deu ruims: ${response.statusCode}');
    }
  }

  Future<void> changeRoute(route) async {
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.title),
        //remove the right hamburger icon
        elevation: 0,
        actions: <Widget>[
          new Container(),
        ],
      ),
      body: Center(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
          ],
          rows: users
              .map((user) => DataRow(
                    cells: [
                      DataCell(Text(user['name'])),
                      DataCell(Text(user['email'])),
                    ],
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _key.currentState!.openEndDrawer(),
        tooltip: 'Criar usuario',
        child: const Icon(Icons.add),
      ),
      endDrawer: Drawer(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final response = await http.post(
                        Uri.parse('http://localhost:3025/users'),
                        body: jsonEncode({
                          'name': nameController.text,
                          'email': emailController.text,
                          'password': passwordController.text,
                        }),
                        headers: {
                          'Content-Type': 'application/json',
                        },
                      );
                      if (response.statusCode == 201) {
                        fetchUsers();
                      } else {
                        // Handle error
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: SidebarX(
        showToggleButton: false,
        controller: SidebarXController(selectedIndex: 0),
        items: [
          SidebarXItem(
            icon: Icons.supervised_user_circle_sharp,
            label: 'Home',
            onTap: () {
              Navigator.of(context).pushNamed('/users');
            },
          ),
          SidebarXItem(
            icon: Icons.folder,
            label: 'Search',
            onTap: () {
              Navigator.of(context).pushNamed('/activity');
            },
          ),
        ],
      ),
    );
  }
}

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<Map<String, dynamic>> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    final url = Uri.parse('http://localhost:3025/activities');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      final List<Map<String, dynamic>> activities =
          responseBody.map((user) => user as Map<String, dynamic>).toList();
      setState(() {
        this.activities = activities;
      });
    } else {
      print('deu ruims: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.title),
        //remove the right hamburger icon
        elevation: 0,
        actions: <Widget>[
          new Container(),
        ],
      ),
      body: Center(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Titulo')),
            DataColumn(label: Text('Descrição')),
          ],
          rows: activities
              .map((activity) => DataRow(
                    cells: [
                      DataCell(Text(activity['title'])),
                      DataCell(Text(activity['description'])),
                    ],
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _key.currentState!.openEndDrawer(),
        tooltip: 'Criar atividade',
        child: const Icon(Icons.add),
      ),
      endDrawer: Drawer(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Titulo'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Descricao'),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final response = await http.post(
                        Uri.parse('http://localhost:3025/activities'),
                        body: jsonEncode({
                          'name': nameController.text,
                          'email': emailController.text,
                          'password': passwordController.text,
                        }),
                        headers: {
                          'Content-Type': 'application/json',
                        },
                      );
                      if (response.statusCode == 201) {
                        fetchActivities();
                      } else {
                        // Handle error
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: SidebarX(
        showToggleButton: false,
        controller: SidebarXController(selectedIndex: 0),
        items: [
          SidebarXItem(
            icon: Icons.verified_user,
            label: 'Home',
            onTap: () {
              Navigator.of(context).pushNamed('/users');
            },
          ),
          SidebarXItem(
            icon: Icons.archive,
            label: 'Search',
            onTap: () {
              Navigator.of(context).pushNamed('/activity');
            },
          ),
        ],
      ),
    );
  }
}
