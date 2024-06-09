class ToDo {
  String? id;
  String? todoText;
  bool? isDone;
  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> todoList() {
    return [
      ToDo(id: "01", todoText: "Check LinkedIn", isDone: true),
      ToDo(id: "02", todoText: "Write Code", isDone: true),
      ToDo(id: "03", todoText: "Visited the Tajmahal today"),
      ToDo(id: "04", todoText: "Taking the photo with my girlfriend"),
      ToDo(id: "05", todoText: "Don't used Instagram once a day"),
      ToDo(id: "06", todoText: "Go to coaching write time"),
      ToDo(
          id: "07",
          todoText: "Belive all the criticle face own life",
          isDone: true),
    ];
  }
}
