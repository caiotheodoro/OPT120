import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiUtils {
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final url = Uri.parse('http://localhost:3025/users');
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

  Future<List<Map<String, dynamic>>>  fetchActivities() async {
    final url = Uri.parse('http://localhost:3025/activities');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      final List<Map<String, dynamic>> activities =
          responseBody.map((user) => user as Map<String, dynamic>).toList();
      return activities;
    } else {
      print('deu ruims: ${response.statusCode}');
    }
  return [];
  }

  Future<List<Map<String, dynamic>>> fetchUserActivities() async {
    final url = Uri.parse('http://localhost:3025/user-activities');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      final List<Map<String, dynamic>> userActivities =
          responseBody.map((user) => user as Map<String, dynamic>).toList();

        print('userActivities: $userActivities');
      return userActivities;
    } else {
      print('deu ruims: ${response.statusCode}');
    }
    return [];
}
}