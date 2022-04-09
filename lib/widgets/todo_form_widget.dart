import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedTodo,
  }) : super(key: key);

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    onChanged: onChangedTitle,
    
    validator: (title) {
      if (title!.isEmpty) {
        return 'The title cannot be empty';
      }
      return null;
    },

    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Title',
    ),
  );

  Widget buildDescription() => TextFormField(
    maxLines: 3,
    initialValue: description,
    onChanged: onChangedDescription,

    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Description',
    ),
  );

  Widget buildSaveButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
      ),
      onPressed: onSavedTodo,
      child: const Text('Save'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(height: 8),
          buildDescription(),
          const SizedBox(height: 10),
          buildSaveButton(),
        ]
      )
    );
  }
}