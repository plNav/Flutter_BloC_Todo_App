import 'dart:async';

import 'package:bloc_testing/data/models/model_todos.dart';
import 'package:bloc_testing/domain/blocs/todos/todos_bloc.dart';
import 'package:bloc_testing/util/console_printer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'todos_status_event.dart';

part 'todos_status_state.dart';

class TodosStatusBloc extends Bloc<TodosStatusEvent, TodosStatusState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;

  TodosStatusBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(TodosStatusLoading()) {
    on<UpdateTodosStatus>(_onUpdateTodosStatus);

    _todosSubscription = _todosBloc.stream.listen((state) {
      if (state is TodosLoaded) {
        printC(red, 'Subscription Called (TodosStatusBloc) => TODOS updated by MAIN');
        add(UpdateTodosStatus(todos: state.todos));
      }
    });
  }

  void _onUpdateTodosStatus(
    UpdateTodosStatus event,
    Emitter<TodosStatusState> emit,
  ) {
    printC(cyan, 'UPDATE TODOS STATUS (TodosStatusBloc)');

    List<Todo> pendingTodos = event.todos
        .where((todo) => todo.isCancelled == false && todo.isCompleted == false)
        .toList();
    List<Todo> completedTodos = event.todos
        .where((todo) => todo.isCompleted == true && todo.isCancelled == false)
        .toList();
    List<Todo> cancelledTodos =
        event.todos.where((todo) => todo.isCancelled == false).toList();

    emit(
      TodosStatusLoaded(
        pendingTodos: pendingTodos,
        completedTodos: completedTodos,
        cancelledTodos: cancelledTodos,
      ),
    );
  }

  @override
  Future<void> close() {
    _todosSubscription.cancel();
    return super.close();
  }
}
