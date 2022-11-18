import 'package:bloc_testing/domain/blocs/todos/todos_bloc.dart';
import 'package:bloc_testing/domain/repositories/abstractions/i_todos_repository.dart';
import 'package:bloc_testing/domain/repositories/dio/dio_todos_repository.dart';
import 'package:bloc_testing/presentation/navigation/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_testing/presentation/navigation/routes.dart';
import 'package:bloc_testing/domain/blocs/simple_bloc_observer.dart';

void main() {
  //printCTest();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ITodosRepository>(create: (_) => DioTodosRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TodosBloc(todosRepository: context.read<ITodosRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'BloC Pattern - Todos',
          routes: Routes.routes,
          initialRoute: home,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xFF000A1F),
            appBarTheme: const AppBarTheme(
              color: Color(0xFF000A1F),
            ),
          ),
          // home: const HomeScreen(),
        ),
      ),
    );
  }
}
