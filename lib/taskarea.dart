import 'package:flutter/material.dart';

class Taskarea extends StatefulWidget {
  const Taskarea({super.key});

  @override
  State<Taskarea> createState() => _TaskareaState();
}

final TextEditingController campoTarefa = TextEditingController();

class _TaskareaState extends State<Taskarea> {
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
              Expanded(
                child: TextField(
                    controller: campoTarefa,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        labelText: 'Adicione uma tarefa',
                        hintText: 'Ex. Dinner with Mary',
                        errorText: null,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff00d7f3), width: 2)),
                        labelStyle: TextStyle(color: Color(0xff00d7f3)))),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
