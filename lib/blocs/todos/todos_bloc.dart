import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/model_todos.dart';

part 'todos_event.dart';

part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(const TodosState()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
  }

  FutureOr<void> _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(
      status: TodosStatus.todosLoaded,
      todos: event.todos,
      lastTodo: event.lastTodo,
    ));
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) {
    emit(state.copyWith(
      status: TodosStatus.todosLoaded,
      todos: List<Todo>.from(state.todos)..add(event.todo!),
      lastTodo: event.todo,
    ));
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    emit(state.copyWith(
      status: TodosStatus.todoDeleted,
      todos: List<Todo>.from(state.todos.where((todo) => event.todo != todo)),
      lastTodo: event.todo,
    ));
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) {
    List<Todo> todos = (state.todos.map((todo) {
      return todo.id == event.todo.id ? event.todo : todo;
    })).toList();
    emit(state.copyWith(status: TodosStatus.todoDeleted, todos: todos));
  }
}
