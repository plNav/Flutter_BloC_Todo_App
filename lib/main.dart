import 'package:bloc_testing/ui/screen_home.dart';
import 'package:bloc_testing/util/console_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/todos/todos_bloc.dart';
import 'blocs/todos_status/todos_status_bloc.dart';
import 'models/model_todos.dart';
import 'navigation/paths.dart';
import 'navigation/routes.dart';
import 'simple_bloc_observer.dart';

void main() {
  //printCTest();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
