import 'dart:convert';
import 'package:http/http.dart' as http;

class UserActivityApiHelper {
  static final String baseUrl = 'http://localhost:3025';

  Future<List<Map<String, dynamic>>> fetchUserActivities() async {
      final url = Uri.parse('$baseUrl/user-activities');
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
   Future<void> createUserActivity(String? id, int userId, int activityId, String deliver, int grade) async {
    final url = Uri.parse('$baseUrl/user-activities/$id');
    final response = await (id != '' ? http.put : http.post)(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'activityId': activityId,
        'deliver': deliver,
        'grade': grade,
      }),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Falha Ao criar a atividade do usuário: ${response.statusCode}');
    }
  }

   Future<void> deleteUserActivity(int id) async {
    final url = Uri.parse('$baseUrl/user-activities/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Falha Ao deletar a atividade do usuário: ${response.statusCode}');
    }
  }
  Future<Map<String, dynamic>> fetchUserActivity(String id) async {
    final url = Uri.parse('$baseUrl/user-activities/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      
      return responseBody;
    } else {
      print('deu ruim: ${response.statusCode}');
    }
    return {};
  }
}
