import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/pages/edit_todo_page.dart';
import 'package:todolist/provider/todos.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  const TodoWidget({required this.todo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        key: ValueKey(todo.id),

        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              label: 'Edit',
              onPressed: (context) => editTodo(context, todo),
              icon: Icons.edit,
            ),
          ],
        ),

        endActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Delete',
              onPressed: (context) => deleteTodo(context, todo),
              icon: Icons.delete,
            ),
          ],
        ),

        child: buildTodo(context),
      ),
    );
  }

  Widget buildTodo(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),

      child: Row(
        children: [
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            checkColor: Colors.white,
            value: todo.isCompleted,
            onChanged: (_) {
              final bool isDone = context.read<TodosProvider>().toggleTodoStatus(todo);

              Utils.showSnackBar(
                context, 
                isDone ? 'Task completed' : 'Task marked incomplete',
              );
            },
          ),

          const SizedBox(width: 20),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                  ),
                ),
          
                if (todo.description.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      todo.description,
                      style: const TextStyle(fontSize: 20, height: 1.5),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void editTodo(BuildContext context, Todo todo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTodoPage(todo: todo),
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final model = context.read<TodosProvider>();
    model.removeTodo(todo);
    Utils.showSnackBar(context, 'Deleted the task');
  }
}
