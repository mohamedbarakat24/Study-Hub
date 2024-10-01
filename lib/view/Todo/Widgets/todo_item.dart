import 'package:flutter/material.dart';
import 'package:study_hub/Model/TodoModel/todo_model.dart';
import 'package:study_hub/utils/constants/colors.dart';
import 'package:study_hub/utils/helpers/helper_functions.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem});

  final TodoModel todo;
  final onToDoChanged;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: dark ? Colors.white54 : MyColors.MyBesto.withOpacity(0.3),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: MyColors.primary,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 18,
            color: MyColors.primary.withOpacity(0.9),
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.zero,
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.red.shade500,
          ),
          child: IconButton(
              color: Colors.white,
              onPressed: () {
                onDeleteItem(todo.id);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 18,
              )),
        ),
      ),
    );
  }
}
