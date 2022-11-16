import 'package:bloc_testing/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:bloc_testing/ui/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/todos/todos_bloc.dart';
import 'models/model_todos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TodosBloc()
            ..add(
              LoadTodos(
                //State Loading -> State Loaded (EmptyList) -> State Loaded (_Todo.todos)
                todos: Todo.todos,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => TodosFilterBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF2c2c54),
          appBarTheme: const AppBarTheme(color: Color(0xFF2c2c54)),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
