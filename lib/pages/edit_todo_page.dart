import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/provider/todos.dart';
import 'package:todolist/widgets/todo_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit Todo'),
          backgroundColor: Theme.of(context).primaryColor,
          
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                final model = context.read<TodosProvider>();
                model.removeTodo(widget.todo);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: saveTodo,
            ),
          ),
        ),
      );

  void saveTodo() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && !isValid) {
      return;
    } 
    else {
      final model = context.read<TodosProvider>();
      model.updateTodo(widget.todo, title, description);
      Navigator.of(context).pop();
    }
  }
}