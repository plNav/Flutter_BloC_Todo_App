import 'package:bloc_testing/ui/screen_add_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todos/todos_bloc.dart';
import '../models/model_todos.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Patter: To Dos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddTodoScreen()),
            ),
          ),
        ],
      ),
      body: BlocConsumer<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state.status == TodosStatus.todoDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(_deleteSnackBar(state, context));
          }
        },
        builder: (context, state) {
          if (state.status == TodosStatus.loadingTodos) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Pending To Dos: ', style: style),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) => _todoCard(
                    todo: state.todos[index],
                    style: style,
                    context: context,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Card _todoCard({
    required Todo todo,
    required TextStyle style,
    required BuildContext context,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('#${todo.id}" ${todo.task}', style: style),
            Row(
              children: [
                IconButton(
                    onPressed: () => context.read<TodosBloc>().add(DeleteTodo(todo: todo)),
                    icon: const Icon(Icons.cancel)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.add_task)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SnackBar _deleteSnackBar(TodosState state, BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          context.read<TodosBloc>().add(AddTodo(todo: state.lastTodo));
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
      ),
      content: Text(
        'To Do Deleted\n${state.lastTodo?.id}: ${state.lastTodo?.task}',
      ),
    );
  }
}
