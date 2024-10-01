import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_hub/Model/TodoModel/todo_model.dart';
import 'package:study_hub/utils/constants/colors.dart';
import 'package:study_hub/utils/helpers/helper_functions.dart';
import 'package:study_hub/view/Todo/Widgets/todo_item.dart';

class TodoItemList extends StatelessWidget {
  final List<TodoModel> foundToDo;
  final Function(TodoModel) onToDoChanged;
  final Function(String) onDeleteItem;

  const TodoItemList({
    Key? key,
    required this.foundToDo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return foundToDo.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset('assets/images/nothing.png'),
                ),
                const SizedBox(height: 40),
                Text(
                  'No To-Dos available.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: dark
                        ? Color.fromARGB(255, 44, 109, 161)
                        : MyColors.primary.withOpacity(0.6),
                  ),
                ),
                Text(
                  'Please add a new one!',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: dark
                        ? Color.fromARGB(255, 44, 109, 161)
                        : MyColors.primary.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          )
        : ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'All To Dos',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: dark ? MyColors.MyBesto : MyColors.primary,
                  ),
                ),
              ),
              for (TodoModel todoo in foundToDo.reversed)
                TodoItem(
                  todo: todoo,
                  onToDoChanged: onToDoChanged,
                  onDeleteItem: onDeleteItem,
                ),
              const SizedBox(height: 70),
            ],
          );
  }
}
