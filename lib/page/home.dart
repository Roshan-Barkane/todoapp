import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final todosList = ToDo.todoList();
List<ToDo> _foundToDo = [];

class _HomePageState extends State<HomePage> {
  TextEditingController _textController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      drawer: const Drawer(
        width: 350,
      ),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          "All ToDo List",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todo in _foundToDo.reversed)
                        TodoItem(
                          todo: todo,
                          onToDoChange: _handelToDoChange,
                          onDeletedItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                elevation: 3,
                backgroundColor: tdBlue,
                onPressed: () {
                  _showDialog();
                },
                child: const Icon(
                  Icons.add,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handelToDoChange(ToDo todo) {
    setState(() {
      if (todo.isDone == false) {
        todo.isDone = true;
      } else {
        todo.isDone = false;
      }
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoItem(String todoText) {
    setState(() {
      todosList.add(
        ToDo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: todoText),
      );
    });
    _textController.clear();
  }

  void _runFilter(String enteredText) {
    List<ToDo> results = [];
    if (enteredText.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where(
            (element) => element.todoText!.toLowerCase().contains(
                  enteredText.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 80,
      backgroundColor: tdBGColor,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20.0, bottom: 10.0),
          height: 50,
          width: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset('assets/images/person.png'),
          ),
        )
      ],
    );
  }

  _showDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: tdBGColor,
        content: SingleChildScrollView(
          child: Container(
            width: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: tdRed,
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    const Text(
                      "Add The Work ToDo",
                      style: TextStyle(
                          color: tdBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Add Text",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(1),
                        prefixIcon: Icon(
                          Icons.brush,
                          color: tdBlue,
                          size: 20,
                        ),
                        prefixIconConstraints: BoxConstraints(
                          maxHeight: 20,
                          minWidth: 25,
                        ),
                        hintText: "Enter Text",
                        hintStyle: TextStyle(color: tdBlack, fontSize: 17),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _addButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _addButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          _addToDoItem(_textController.text);
        },
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: tdBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(1),
            prefixIcon: Icon(
              Icons.search_sharp,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            hintText: "Search",
            hintStyle: TextStyle(color: tdBlack),
            border: InputBorder.none),
      ),
    );
  }
}
