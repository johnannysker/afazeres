class Tarefa {
  Tarefa({required this.title, required this.dateTime});

  Tarefa.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        dateTime = DateTime.parse(json['datetime']);

  String title;
  DateTime dateTime;

  Map<String, dynamic> toJson() {
    return {'title': title, 'datetime': dateTime.toString()};
  }
}
