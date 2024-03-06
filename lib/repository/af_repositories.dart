import 'dart:convert';
import 'package:afazeres/models/tarefa.dart';
import 'package:shared_preferences/shared_preferences.dart';

const tarefaKey = 'List_tasks';

class AfRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Tarefa>> getListTarefa() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(tarefaKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Tarefa.fromJson(e)).toList();
  }

  void saveListTarefa(List<Tarefa> tarefas) {
    final String jsonString = json.encode(tarefas);
    sharedPreferences.setString(tarefaKey, jsonString);
  }
}
