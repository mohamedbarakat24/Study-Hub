import 'package:flutter/material.dart';
import 'package:study_hub/Model/TodoModel/todo_model.dart';
import 'package:study_hub/utils/constants/colors.dart';
import 'package:study_hub/view/Todo/Widgets/add_todo_bar.dart';
import 'package:study_hub/view/Todo/Widgets/custom_search_bar.dart';
import 'package:study_hub/view/Todo/Widgets/todo_item_list.dart';

class ToDoScreen extends StatefulWidget {
  ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final todosList = TodoModel.todoList();
  final _todoController = TextEditingController();
  List<TodoModel> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                CustomSearchBar(onSearch: _runFilter),
                Expanded(
                  child: TodoItemList(
                    foundToDo: _foundToDo,
                    onToDoChanged: _handleToDoChanges,
                    onDeleteItem: _deleteToDoItem,
                  ),
                ),
              ],
            ),
          ),
          AddToDoBar(
            controller: _todoController,
            onAddPressed: () {
              _addToDoItem(_todoController.text);
            },
          ),
        ],
      ),
    );
  }

  void _handleToDoChanges(TodoModel todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      if (toDo.isNotEmpty) {
        todosList.add(TodoModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: toDo,
        ));
      }
    });
    _todoController.clear();
  }

  void _runFilter(String enterKeyword) {
    List<TodoModel> results = [];
    if (enterKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((element) => element.todoText!
              .toLowerCase()
              .contains(enterKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: MyColors.MyBesto,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 45,
            width: 45,
            child: Image.asset('assets/images/logo.png'),
          ),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: MyColors.MyDarkTheme,
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
