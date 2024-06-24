import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project4summamove/models/achievement.dart';
import 'package:project4summamove/services/authentication_services.dart';
import 'package:project4summamove/services/base_url.dart';

class AchievementServices {
  Future<List<Achievement>> getAll({int? moveId}) async {
    List<Achievement> achievements = [];
    var userId = await AuthenticationServices().userId();

    String url = userId == null
        ? '$baseUrl/items/achievements'
        : '$baseUrl/items/achievements/$userId/$moveId';

    final response = await http.get(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
    });
    if (response.statusCode != 200) {
      throw Exception('Onverwachte responsecode ${response.statusCode}');
    }

    final List<dynamic> body = jsonDecode(response.body);

    for (int i = 0; i < body.length; i++) {
      final achievement = Achievement(
        id: body[i]['id'],
        exerciseID: body[i]['exerciseID'],
        userID: body[i]['userID'],
        datum: body[i]['datum'],
        amount: body[i]['amount'],
      );
      print(achievement.id);
      achievements.add(achievement);
    }

    return achievements;
  }

  Future<Achievement> post(
      { required int exerciseID,
        required DateTime datum,
        required int amount}) async {
    String date = datum.year.toString() + '-' + datum.month.toString() + '-' + datum.day.toString();
    var userID = await AuthenticationServices().userId();
    final response = await http.post(Uri.parse('$baseUrl/items/achievements'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
        },
        body: jsonEncode({
          "exerciseID": exerciseID,
          "userID": userID,
          "datum": date,
          "amount": amount,
        }));

    if (response.statusCode != 201) {
      throw Exception(
          'Onverwachte statuscode (${response.statusCode}) bij het toevoegen van een achievement.');
    }
    final json = jsonDecode(response.body);
    // print(json);

    // int xx1 = json['data']['id'];
    // print('aa1');
    // int xx2 = json['data']['exerciseID'];
    // print('aa2');
    // print(int.parse(json['data']['userID']).toString());
    // int xx3 = int.parse(json['data']['userID']);
    // print('aa3');
    // String xx4 = json['data']['datum'].toString();
    // print('aa4');
    // int xx5 = json['data']['amount'];
    // print('aa5');

    return Achievement(
      id: json['data']['id'],
      exerciseID: json['data']['exerciseID'],
      userID: int.parse(json['data']['userID']),
      datum: json['data']['datum'].toString(),
      amount: json['data']['amount'],
    );
  }

  Future<Achievement> update(
      {required int achievementId,
        required int exerciseID,
        required int userID,
        required String datum,
        required int amount}) async {
    final response = await http.put(Uri.parse('$baseUrl/items/achievements/$achievementId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
        },
        body: jsonEncode({
          "id": achievementId,
          "exerciseID": exerciseID,
          "userID": userID,
          "datum": datum,
          "amount": amount,
        }));

    if (response.statusCode != 200) {
      throw Exception(
          'Onverwachte statuscode (${response.statusCode}) bij het toevoegen van een achievement.');
    }
    final json = jsonDecode(response.body);

    // print(json);
    // int xx1 = json['data']['id'];
    // print('aa1');
    // int xx2 = json['data']['exerciseID'];
    // print('aa2');
    // print((int.parse(json['data']['userID'].toString())).toString());
    // int xx3 = int.parse(json['data']['userID'].toString());
    // print('aa3');
    // String xx4 = json['data']['datum'].toString();
    // print('aa4');
    // int xx5 = json['data']['amount'];
    // print('aa5');



    return Achievement(
      id: json['data']['id'],
      exerciseID: json['data']['exerciseID'],
      userID: json['data']['userID'],
      datum: json['data']['datum'].toString(),
      amount: json['data']['amount'],
    );
  }


  Future<void> delete({required int achievementId}) async {
    print(achievementId);
    final response = await http
        .delete(Uri.parse('$baseUrl/items/achievements/$achievementId'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
    });
    if (response.statusCode != 200) {
      throw Exception(
          'Onverwachte response statuscode: ${response.statusCode}');
    }
  }


}
