import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/model_todos.dart';
import '../../util/console_printer.dart';
import '../todos/todos_bloc.dart';

part 'todos_filter_event.dart';

part 'todos_filter_state.dart';

class TodosFilterBloc extends Bloc<TodosFilterEvent, TodosFilterState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todosSubscription;

  TodosFilterBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(const TodosFilterState()) {
    on<UpdateTodos>(_onUpdateTodos);
    on<UpdateFilter>(_onUpdateFilter);

    _todosSubscription = todosBloc.stream.listen((todoState) {
      printC(SUCCESS, 'ToDos Length = ${todoState.todos.length}');
      add(UpdateFilter(todos: todoState.todos));
    });
  }

  FutureOr<void> _onUpdateTodos(UpdateTodos event, Emitter<TodosFilterState> emit) {
    if(event.todosFilterStatus == TodosFilterStatus.pending){
      List<Todo> pendingTodos = state.todosFiltered
          .where((todo) => todo.isCancelled == false && todo.isCompleted == false)
          .toList();
      emit(state.copyWith(todosFiltered: pendingTodos));
      printC(BLUE, 'Pending ToDos = ${pendingTodos.length}');
      return null;
    }
    if(event.todosFilterStatus == TodosFilterStatus.completed){
      List<Todo> completedTodos = state.todosFiltered
          .where((todo) => todo.isCompleted == true && todo.isCancelled == false)
          .toList();
      printC(BLUE, 'Pending ToDos = ${completedTodos.length}');
      emit(state.copyWith(todosFiltered: completedTodos));
    }
  }

  FutureOr<void> _onUpdateFilter(UpdateFilter event, Emitter<TodosFilterState> emit) {
    emit(state.copyWith(status: state.status, todosFiltered: event.todos));
  }
}
