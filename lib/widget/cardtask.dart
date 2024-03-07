import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class Cardtask extends StatelessWidget {
  const Cardtask({super.key, required this.afazer, required this.onDelete});

  final Tarefa afazer;
  final Function(Tarefa) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Slidable(
        actionExtentRatio: 0.15,
        actionPane: const SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: 'Excluir',
            onTap: () {
              onDelete(afazer);
            },
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromARGB(255, 81, 122, 133),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(DateFormat("dd/MM/yyyy").format(afazer.dateTime),
                  style: const TextStyle(fontSize: 12, color: Colors.white70)),
              Text(
                afazer.title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 221, 221, 221)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
