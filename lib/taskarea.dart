import 'package:flutter/material.dart';
import 'package:afazeres/models/tarefa.dart';
import 'package:afazeres/widget/cardtask.dart';
import 'package:afazeres/repository/af_repositories.dart';

class Taskarea extends StatefulWidget {
  const Taskarea({super.key});

  @override
  State<Taskarea> createState() => _TaskareaState();
}

final TextEditingController campoTarefa = TextEditingController();
final AfRepository afRepository = AfRepository();

class _TaskareaState extends State<Taskarea> {
  List<Tarefa> task = [];
  Tarefa? tarefasDeletadas;
  int? posTarefaDeletada;

  //callback para deletar uma tarefa
  void onDelete(Tarefa tarefa) {
    tarefasDeletadas = tarefa;
    posTarefaDeletada = task.indexOf(tarefa);
    setState(() {
      task.remove(tarefa);
    });
    afRepository.saveListTarefa(task);

    ScaffoldMessenger.of(context)
        .clearSnackBars(); //limpa a mensagem do Snackbar
//Widget que avisa quando a tarefa for deletada
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'A tarefa ${tarefa.title} foi removida!',
          style: const TextStyle(color: Color(0xffffffff), fontSize: 15),
        ),
        backgroundColor: Colors.purple[900],
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: const Color(0xff00d7f3),
          onPressed: () {
            setState(() {
              //devolvendo a tarefa excluida na lista de tarefas
              task.insert(posTarefaDeletada!, tarefasDeletadas!);
            });
            afRepository.saveListTarefa(task);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  String? erroText;

  @override
  void initState() {
    super.initState();
    afRepository.getListTarefa().then((value) {
      setState(() {
        task = value;
      });
    });
  }

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
                      afRepository.saveListTarefa(task);
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
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: dialogoDeConfirmacaoDeExclusao,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff00d7f3),
                        padding: const EdgeInsets.all(6),
                      ),
                      child: const Text('Limpar tudo'))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

//Caixa de dialogo para confirmação de exclusão das tarefas
  void dialogoDeConfirmacaoDeExclusao() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Limpar tudo?',
          style: TextStyle(color: Color(0xff00d7f3)),
        ),
        content: const Text('Confirme se deseja excluir todas as tarefas.'),
        actions: [
          TextButton(
              //Botão cancelar
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              //Botão confirmar
              onPressed: () {
                Navigator.of(context).pop();
                deleteTodasTarefas(); //chamando método para excluir tudo
              },
              style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text(
                'Confirmar',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  //Método de deletar todas as tarefas
  void deleteTodasTarefas() {
    setState(() {
      task.clear();
    });
    afRepository.saveListTarefa(task);
  }
}
