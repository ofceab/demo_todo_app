import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/repositories/todo_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TodoRepository _todoRepository;

  @override
  void initState() {
    super.initState();
    _todoRepository = TodoRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo app')),
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder<List<Todo>>(
          future: _todoRepository.obtenirLesTodos(),
          builder: (_, donnees) {
            if (donnees.connectionState == ConnectionState.done) {
              final todos = donnees.data!;

              return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (_, index) => ListTile(
                        leading: CircleAvatar(
                            child: Text(todos[index].id.toString())),
                        title: Text(todos[index].titre,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w900)),
                        subtitle: Text(
                          todos[index].contenu,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ));
            } else if (donnees.connectionState == ConnectionState.waiting ||
                donnees.connectionState == ConnectionState.active) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(
              child: Text('Il ya eu une erreur'),
            );
          }),
    );
  }
}
