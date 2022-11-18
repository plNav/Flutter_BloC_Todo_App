import 'package:bloc_testing/presentation/navigation/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/navigation/routes.dart';
import 'domain/blocs/simple_bloc_observer.dart';

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
