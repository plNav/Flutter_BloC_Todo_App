import 'package:bloc_testing/data/models/model_todos.dart';
import 'package:bloc_testing/domain/blocs/todos/todos_bloc.dart';
import 'package:bloc_testing/domain/blocs/todos_status/todos_status_bloc.dart';
import 'package:bloc_testing/presentation/navigation/paths.dart';
import 'package:bloc_testing/presentation/screens/screen_add_todo.dart';
import 'package:bloc_testing/presentation/screens/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Routes {
  static final _todosBloc = TodosBloc();

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) {
        return MultiBlocProvider(providers: [
          BlocProvider.value(
            value: _todosBloc..add(LoadTodos(todos: Todo.todos)),
          ),
          BlocProvider(create: (context) {
            return TodosStatusBloc(todosBloc: BlocProvider.of<TodosBloc>(context));
          }),
        ], child: HomeScreen());
      },
      addTodo: (context) {
        return BlocProvider.value(value: _todosBloc, child: AddTodoScreen());
      }
    };
  }
}
