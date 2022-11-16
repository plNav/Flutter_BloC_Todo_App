import 'package:bloc_testing/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:bloc_testing/ui/screen_add_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todos/todos_bloc.dart';
import '../models/model_todos.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BloC Pattern: To Dos'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddTodoScreen()),
              ),
            ),
          ],
          bottom: TabBar(
            onTap: (tabIndex) {
              switch (tabIndex) {
                case 0:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                    const UpdateTodos(todosFilterStatus: TodosFilterStatus.pending),
                  );
                  break;
                case 1:
                  BlocProvider.of<TodosFilterBloc>(context).add(
                    const UpdateTodos(todosFilterStatus: TodosFilterStatus.completed),
                  );
                  break;
              }
            },
            tabs: const [
              Tab(icon: Icon(Icons.pending)),
              Tab(icon: Icon(Icons.add_task)),
            ],
          ),
        ),
        body: TabBarView(
          children: [_todoTab('Pending To Dos: '), _todoTab('Completed To Dos: ')],
        ),
      ),
    );
  }

  BlocConsumer<TodosFilterBloc, TodosFilterState> _todoTab(String title) {
    const style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    return BlocConsumer<TodosFilterBloc, TodosFilterState>(
      listener: (context, state) {
        if (state.status == TodosStatus.deleted) {
          //ScaffoldMessenger.of(context).removeCurrentSnackBar();
          //ScaffoldMessenger.of(context).showSnackBar(_deleteSnackBar(state, context));
        }
      },
      builder: (context, state) {
        if (state.status == TodosStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(title, style: style),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.todosFiltered.length,
                itemBuilder: (context, index) => _todoCard(
                  todo: state.todosFiltered[index],
                  style: style,
                  context: context,
                ),
              ),
            ],
          ),
        );
      },
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
            Text('#${todo.id} - ${todo.task}', style: style),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () => context.read<TodosBloc>().add(
                        DeleteTodo(todo: todo),
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_task),
                  onPressed: () => context.read<TodosBloc>().add(
                        UpdateTodo(todo: todo.copyWith(isCompleted: true)),
                      ),
                ),
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
        'To Do Deleted: ${state.lastTodo?.task}',
      ),
    );
  }
}
