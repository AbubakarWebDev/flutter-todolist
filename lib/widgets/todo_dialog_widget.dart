import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/provider/todos.dart';
import 'package:todolist/widgets/todo_form_widget.dart';
import 'package:uuid/uuid.dart';

class TodoDialogWidget extends StatefulWidget {
  const TodoDialogWidget({ Key? key }) : super(key: key);

  @override
  _TodoDialogWidgetState createState() => _TodoDialogWidgetState();
}

class _TodoDialogWidgetState extends State<TodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Form(
        key: _formKey,
        child: Stack(
          children: [
            Positioned(
              top: 15,
              right: 10,
              child: buildCloseButton(),
            ),
            buildForm(),
          ]
        )
      )
    );
  }

  Widget buildCloseButton() {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.black,
        shape: CircleBorder(),
      ),

      width: 30,
      height: 30,

      child: IconButton(
        iconSize: 15,
        color: Colors.white,
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget buildForm() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Add Todo",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            )
          ),

          const SizedBox(height: 8),

          TodoFormWidget(
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) => setState(() => this.description = description),
            onSavedTodo: () => addTodo()
          ),
        ],
      )
    );
  }

  void addTodo() {
    final bool? isValid = _formKey.currentState?.validate();

    if (isValid != null && !isValid) {
      return;
    }
    else {
      final todo = Todo(
        id: const Uuid().v4(),
        createdTime: DateTime.now(),
        title: title,
        description: description
      );

      final model = context.read<TodosProvider>();
      model.addTodo(todo);
      
      Navigator.of(context).pop();
    }
  }
}