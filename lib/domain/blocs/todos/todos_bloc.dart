import 'dart:async';

import 'package:bloc_testing/data/models/model_todos.dart';
import 'package:bloc_testing/util/console_printer.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_testing/domain/repositories/abstractions/i_todos_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todos_event.dart';

part 'todos_state.dart';

class TodosBloc extends Bloc<TodoEvent, TodosState> {
  final ITodosRepository todosRepository;

  TodosBloc({required this.todosRepository}) : super(TodosLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<TodoError>(_onTodoError);
    on<TodoErrorDone>(_onTodoErrorDone);
  }

  FutureOr<void> _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    final todos = await todosRepository.getAll();
    printC(purple, 'LOAD TODOS (TodosBloc)');
    emit(TodosLoaded(todos: todos));
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) {
    if (state is TodosLoading) {
      return;
    }
    printC(purple, 'ADD TODO DONE (TodosBloc)');
    emit(
      TodosAdded(
        lastTodo: event.todo,
        todos: List.from((state as TodosLoaded).todos)
          ..add(event.todo.copyWith(isCompleted: false, isCancelled: false)),
      ),
    );
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    if (state is TodosLoading) {
      return;
    }
    printC(purple, 'DELETE TODO (TodosBloc)');
    final curState = state as TodosLoaded;
    final List<Todo> todos = curState.todos.where((todo) => todo.id != event.todo.id).toList();
    emit(TodosDeleted(todos: todos, lastTodo: event.todo));
  }

  void _onUpdateTodo(
    UpdateTodo event,
    Emitter<TodosState> emit,
  ) {
    if (state is TodosLoading) {
      return;
    }
    printC(purple, 'UPDATE TODO (TodosBloc)');
    final curState = state as TodosLoaded;
    List<Todo> todos =
        curState.todos.map((todo) => todo.id == event.todo.id ? event.todo : todo).toList();
    emit(TodosUpdated(todos: todos, lastTodo: event.todo));
  }

  void _onTodoError(TodoError event, Emitter<TodosState> emit) {
    printC(purple, 'ERROR TODO', printLabel: true);
    final curState = state as TodosLoaded;
    emit(TodosError(todos: List.from(curState.todos), lastTodo: (curState.lastTodo)));
  }

  FutureOr<void> _onTodoErrorDone(TodoErrorDone event, Emitter<TodosState> emit) {
    printC(purple, 'ERROR TODO DONE');
    final curState = state as TodosLoaded;
    emit(TodosLoaded(todos: List.from(curState.todos), lastTodo: (curState.lastTodo)));
  }
}
