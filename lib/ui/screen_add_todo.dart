import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todos/todos_bloc.dart';
import '../models/model_todos.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: Add a ToDo'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state.status != TodosStatus.todoDeleted) return;
          ScaffoldMessenger.of(context).showSnackBar(_addSnackBar(state.lastTodo));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _inputField('ID', controllerId),
                _inputField('Task', controllerTask),
                _inputField('Description', controllerDescription),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      var todo = Todo(
                        id: controllerId.value.text,
                        task: controllerTask.value.text,
                        description: controllerDescription.value.text,
                      );
                      context.read<TodosBloc>().add(AddTodo(todo: todo));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add To Do')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SnackBar _addSnackBar(Todo? todo) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New ToDo\n${todo?.id}: ${todo?.task}',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Column _inputField(String field, TextEditingController controller) {
    const style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$field: ', style: style),
        Container(
          height: 50,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          child: TextFormField(controller: controller),
        ),
      ],
    );
  }
}
