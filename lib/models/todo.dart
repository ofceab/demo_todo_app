class Todo {
  Todo.fromParam(
      {required this.id, required this.titre, required this.contenu});

  factory Todo.fromJson(Map<String, dynamic> row) {
    return Todo.fromParam(
        id: row['id'], titre: row['titre']!, contenu: row['contenu']!);
  }

  late int id;
  late String titre;
  late String contenu;

  Map<String, dynamic> toJson() {
    return {'id': id, 'titre': titre, 'contenu': contenu};
  }
}
