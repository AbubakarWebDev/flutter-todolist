class Todo {
  String id;
  String title;
  String description;
  DateTime createdTime;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.createdTime,
    this.description = "",
    this.isCompleted = false,
  });
}