import 'package:flutter/material.dart';
import 'package:afazeres/models/tarefa.dart';

class Taskarea extends StatefulWidget {
  const Taskarea({super.key});

  @override
  State<Taskarea> createState() => _TaskareaState();
}

final TextEditingController campoTarefa = TextEditingController();

List<Tarefa> task = [];

class _TaskareaState extends State<Taskarea> {
  String? erroText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 49, 63),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: campoTarefa,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            labelText: 'Adicione uma tarefa',
                            hintText: 'Ex. Dinner with Mary',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 124, 124, 124)),
                            errorText: erroText,
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff00d7f3), width: 2)),
                            labelStyle:
                                const TextStyle(color: Color(0xff00d7f3)))),
                  ),
                  const SizedBox(
                    //Sepára o campo de texto do botão '+'
                    width: 8,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xff00d7f3),
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () {
                      String text = campoTarefa.text;

                      if (text.isEmpty) {
                        setState(() {
                          erroText = 'ATENÇÂO! Adicione o titulo da tarefa.';
                        });
                        return;
                      }

                      setState(() {
                        Tarefa novaTarefa =
                            Tarefa(title: text, dateTime: DateTime.now());
                        task.add(novaTarefa);
                        erroText = null;
                      });
                      campoTarefa.clear();
                      //todoRepository.saveListTarefa(tarefas);
                    },
                    child: const Icon(
                      color: Colors.black54,
                      Icons.add,
                      size: 30,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "Você possui ${task.length} tarefas pendentes",
                    style: const TextStyle(color: Colors.cyanAccent),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
