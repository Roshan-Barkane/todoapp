import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onDeletedItem;
  const TodoItem(
      {Key? key, required this.todo, this.onToDoChange, this.onDeletedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // print("listtile is work sucessfully");
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 17,
              color: tdBlack,
              decoration: todo.isDone! ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdBGColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: IconButton(
            onPressed: () {
              //  print("Check the delete button ");
              onDeletedItem(todo.id);
            },
            icon: Icon(Icons.delete),
            color: tdRed,
            iconSize: 20,
          ),
        ),
      ),
    );
  }
}
