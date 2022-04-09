import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/todos.dart';
import 'package:todolist/widgets/todo_dialog_widget.dart';
import 'package:todolist/widgets/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({ 
    Key? key, 
    required this.title
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(todos: context.watch<TodosProvider>().todos),
      TodoListWidget(todos: context.watch<TodosProvider>().completedTodos),
    ];

    return Scaffold(
      appBar: AppBar (
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,

        title: Text(
          widget.title,
          textDirection: TextDirection.ltr,
        ),
      ),

      body: tabs[selectedIndex],

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => showDialog(
          context: context, 
          builder: (BuildContext context) => const TodoDialogWidget(),
          barrierDismissible: false
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,

        onTap: (index) => setState((){
          selectedIndex = index;
        }),
        
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: "Todos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: "Completed",
          ),
        ],
      ),
    );
  }
}