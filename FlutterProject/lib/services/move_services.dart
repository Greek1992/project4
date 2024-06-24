import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project4summamove/models/move.dart';
import 'package:project4summamove/services/base_url.dart';

class MoveServices {
  final String urlMoves = '$baseUrl/items/exercises';

  Future<List<Move>> getAll() async {
    List<Move> moves = [];

    final response = await http.get(Uri.parse(urlMoves));
    if (response.statusCode != 200) {
      throw Exception('Onverwachte responsecode ${response.statusCode}');
    }
    print(response);
    final List<dynamic> body = jsonDecode(response.body);

    for (int i = 0; i < body.length; i++) {
      final move = Move(
        id: body[i]['id'],
        name: body[i]['name'],
        instructionEN: body[i]['instructionEN'],
        instructieNL: body[i]['instructieNL'],
      );

      moves.add(move);
    }

    return moves;
  }

  Future<Move> getMove(int id) async {
    var urlMoves1 = '$urlMoves/$id';
    final response = await http.get(Uri.parse(urlMoves1));
    if (response.statusCode != 200) {
      throw Exception('Onverwachte responsecode ${response.statusCode}');
    }

    final Map<String, dynamic> body = jsonDecode(response.body);

    final move = Move(
      id: body['id'],
      name: body['name'],
      instructionEN: body['instructionEN'],
      instructieNL: body['instructieNL'],
    );

    return move;
  }
}
