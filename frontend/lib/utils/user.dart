import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApiHelper {
  static final String baseUrl = 'http://localhost:3025';

Future<List<Map<String, dynamic>>> fetchUsers() async {
    final url = Uri.parse('$baseUrl/users');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      final List<Map<String, dynamic>> users =
          responseBody.map((user) => user as Map<String, dynamic>).toList();
      return users;
    } else {
      print('deu ruims: ${response.statusCode}');
    }
    return [];
  }

   Future<void> createUser(String? id, String name, String email, String password) async {

    dynamic url = Uri.parse('$baseUrl/users/$id');
    final response = await (id != '' ? http.put : http.post)(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
     
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Falha Ao criar user: ${response.statusCode}');
    }
  }

   Future<void> deleteUser(int id) async {
    final url = Uri.parse('$baseUrl/users/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Falha Ao deletar user: ${response.statusCode}');
    }
  }
  Future<Map<String, dynamic>> fetchUser(int id) async {
    final url = Uri.parse('$baseUrl/users/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      print('deu ruim: ${response.statusCode}');
    }
    return {};
  }
}