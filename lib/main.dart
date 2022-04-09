import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/pages/home_page.dart';
import 'package:todolist/provider/todos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = "TodoList Application";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosProvider(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
      
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.indigo[900],
          scaffoldBackgroundColor: Colors.grey[200]
        ),

        home: const HomePage(title: _title),
      )
    );
  }
}
