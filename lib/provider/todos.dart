import 'package:flutter/material.dart';
import 'package:todolist/model/todo.dart';
import 'package:uuid/uuid.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
      id: const Uuid().v4(),
      createdTime: DateTime.now(),
      title: 'Buy Food 😋',
      description: '''- Eggs
- Milk
- Bread
- Water''',
    ),
    Todo(
      id: const Uuid().v4(),
      createdTime: DateTime.now(),
      title: 'Plan family trip to Norway',
      description: '''- Rent some hotels
- Rent a car
- Pack suitcase''',
    ),
    Todo(
      id: const Uuid().v4(),
      createdTime: DateTime.now(),
      title: 'Walk the Dog 🐕',
    ),
    Todo(
      id: const Uuid().v4(),
      createdTime: DateTime.now(),
      title: 'Plan Jacobs birthday party 🎉🥳',
    ),
  ];

  List<Todo> get todos {
    return _todos.where((todo) => todo.isCompleted == false).toList();
  }

  List<Todo> get completedTodos {
    return _todos.where((todo) => todo.isCompleted == true).toList();
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isCompleted = !todo.isCompleted;
    notifyListeners();
    return todo.isCompleted;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }
}
