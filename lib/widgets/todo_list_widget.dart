import 'package:flutter/material.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/widgets/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  final List<Todo> todos;
  const TodoListWidget({ Key? key, required this.todos }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
    ? const Center(
        child: Text(
          'No todos.',
          style: TextStyle(fontSize: 20),
        ),
      )
    : ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) => Container(height: 8),
        itemCount: todos.length,

        itemBuilder: (context, index) {
          final todo = todos[index];
          return TodoWidget(todo: todo);
        },
      );
  }
}