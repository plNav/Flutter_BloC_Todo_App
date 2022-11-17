import 'package:bloc_testing/ui/screen_add_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todos/todos_bloc.dart';

import '../blocs/todos_status/todos_status_bloc.dart';
import '../models/model_todos.dart';
import '../util/console_printer.dart';
import '../util/info_popup.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodosBloc, TodosState>(
      listener: (context, mainState) {
        printC(SUCCESS, 'MAIN state ---> ${mainState.runtimeType}');
        if (mainState is TodosDeleted) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(_deleteSnackBar(mainState, context));
          return;
        }

        if (mainState is TodosUpdated) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(_updateSnackBar(mainState, context));
          return;
        }

        if (mainState is TodosAdded) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(_addSnackBar(mainState, context));
          return;
        }

        if (mainState is TodosError) {
          printC(ERROR, 'MAIN STATE ERROR');
          InfoPopup.show(context: context, text: ['Se ha producido un Error']);
        }
      },
      child: BlocBuilder<TodosStatusBloc, TodosStatusState>(
        builder: (context, state) {
          printC(WARNING, 'STATUS state ---> ${state.runtimeType}');
          if (state is TodosStatusLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is! TodosStatusLoaded) {
            return const Center(child: Text('Something Went Wrong'));
          }

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('BloC Pattern: To Dos'),
                actions: [
                  IconButton(
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const AddTodoScreen())),
                    icon: const Icon(Icons.add),
                  ),
                ],
                bottom: const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.pending)),
                    Tab(icon: Icon(Icons.add_task)),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                  children: [
                    _todo(state.pendingTodos, 'Pending', context),
                    _todo(state.completedTodos, 'Completed', context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column _todo(List<Todo> todos, String status, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$status To Dos: ',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.error),
                onPressed: () =>
                    context.read<TodosBloc>().add(const TodoError()),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (context, index) => _todosCard(context, todos[index]),
        ),
      ],
    );
  }

  Card _todosCard(BuildContext context, Todo todo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#${todo.id}: ${todo.task}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<TodosBloc, TodosState>(
              builder: (context, state) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<TodosBloc>().add(
                          UpdateTodo(
                            todo: todo.copyWith(isCompleted: true),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_task),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<TodosBloc>().add(
                          DeleteTodo(
                            todo: todo.copyWith(isCancelled: true),
                          ),
                        );
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////// SNACK BARS ////////////////////////////////////////////

  SnackBar _deleteSnackBar(TodosState state, BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          if ((state as TodosLoaded).lastTodo == null) {
            return;
          }
          printC(PURPLE, 'ADD TODO FROM "UNDO"');
          context.read<TodosBloc>().add(AddTodo(todo: state.lastTodo!));
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
      ),
      content: Text(
        'To Do Deleted: ${(state as TodosLoaded).lastTodo?.task}',
        style: const TextStyle(color: Colors.redAccent),
      ),
    );
  }

  SnackBar _updateSnackBar(TodosState state, BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        'To Do Completed: ${(state as TodosLoaded).lastTodo?.task}',
        style: const TextStyle(color: Colors.greenAccent),
      ),
    );
  }

  SnackBar _addSnackBar(TodosState state, BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        'New To Do: ${(state as TodosLoaded).lastTodo?.task}',
        style: const TextStyle(color: Colors.greenAccent),
      ),
    );
  }
}
