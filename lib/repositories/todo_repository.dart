import 'dart:convert';
import 'dart:io';

import '../models/todo.dart';
import 'package:http/http.dart' as http;

class TodoRepository {
  final String serverLink = 'http://localhost:8888/';

  Future<List<Todo>> obtenirLesTodos() async {
    try {
      final uri = Uri.parse('${serverLink}todo');
      final response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        return List.from(json.decode(response.body))
            .map((todo) => Todo.fromJson(todo))
            .toList();
      }
      return [];
    } catch (e, stack) {
      print(e);
      print(stack);
      return [];
    }
  }

  Future<Todo?> obtenirTodo(int todoId) async {
    final uri = Uri.parse('${serverLink}todo/$todoId');
    final response = await http.get(uri);
    if (response.statusCode == HttpStatus.ok) {
      return Todo.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<bool> creerTodo(Todo todo) async {
    final uri = Uri.parse('${serverLink}todo');
    final response = await http.post(uri, body: todo.toJson());

    return response.statusCode == HttpStatus.created;
  }

  Future<bool> mettreAJourTodo(int todoId, Todo todo) async {
    final uri = Uri.parse('${serverLink}todo/$todoId');
    final response = await http.put(uri, body: todo.toJson());

    return response.statusCode == HttpStatus.created;
  }

  Future<bool> supprimerTodo(int todoId) async {
    final uri = Uri.parse('${serverLink}todo/$todoId');
    final response = await http.delete(uri);

    return response.statusCode == HttpStatus.ok;
  }

  Future<bool> supprimerToutTodos() async {
    final uri = Uri.parse('${serverLink}todo');
    final response = await http.delete(uri);

    return response.statusCode == HttpStatus.ok;
  }
}
