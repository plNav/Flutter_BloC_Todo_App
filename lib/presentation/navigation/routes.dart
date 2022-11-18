import 'package:bloc_testing/domain/blocs/todos/todos_bloc.dart';
import 'package:bloc_testing/domain/blocs/todos_status/todos_status_bloc.dart';
import 'package:bloc_testing/presentation/navigation/paths.dart';
import 'package:bloc_testing/presentation/screens/screen_add_todo.dart';
import 'package:bloc_testing/presentation/screens/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<TodosBloc>()..add(const LoadTodos(todos: [])),
            ),
            BlocProvider(create: (context) =>
              TodosStatusBloc(todosBloc: BlocProvider.of<TodosBloc>(context))
            ),
          ],
          child: const HomeScreen(),
        );
      },
      addTodo: (context) =>
          BlocProvider.value(value: context.read<TodosBloc>(), child: const AddTodoScreen())
    };
  }
}
