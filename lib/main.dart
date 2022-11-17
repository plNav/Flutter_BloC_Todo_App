import 'package:bloc_testing/ui/screen_home.dart';
import 'package:bloc_testing/util/console_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/todos/todos_bloc.dart';
import 'blocs/todos_status/todos_status_bloc.dart';
import 'models/model_todos.dart';
import 'simple_bloc_observer.dart';

void main() {
  printTest();
  BlocOverrides.runZoned(
        () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) {
              printC(SUCCESS, '(Main) Initialize TodosBloc with LoadTodos Event with values');
              return TodosBloc()
                ..add(
                  LoadTodos(
                    todos: [
                      Todo(
                        id: '1',
                        task: 'BloC Pattern Video',
                        description: 'Explain what is the BloC Pattern',
                      ),
                      Todo(
                        id: '2',
                        task: 'BloC Pattern Video #2',
                        description: 'Explain what is the BloC Pattern',
                      ),
                    ],
                  ),
                );
            }
        ),
        BlocProvider(
            create: (context) {
              printC(SUCCESS, '(Main) Initialize TodosStatusBloc with UpdateTodosStatus Event');
              return TodosStatusBloc(
                todosBloc: BlocProvider.of<TodosBloc>(context),
              );//..add(const UpdateTodosStatus());
            }
        ),
      ],
      child: MaterialApp(
        title: 'BloC Pattern - Todos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF000A1F),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF000A1F),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
