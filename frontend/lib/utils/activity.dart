import 'dart:convert';
import 'package:http/http.dart' as http;

class ActivityApiHelper {
  static final String baseUrl = 'http://localhost:3025';

  Future<List<Map<String, dynamic>>>  fetchActivities() async {
      final url = Uri.parse('$baseUrl/activities');
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

   Future<void> createActivity(String? id, String title, String description, String date) async {
    final url = Uri.parse('$baseUrl/activities/$id');
   
    final response = await (id != '' ? http.put : http.post)(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'description': description,
        'date': date,
      }),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Falha Ao criar activity: ${response.statusCode}');
    }
  }

   Future<void> deleteActivity(int id) async {
    final url = Uri.parse('$baseUrl/activities/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Falha Ao deletar activity: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchActivity(int id) async {
    final url = Uri.parse('$baseUrl/activities/$id');
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