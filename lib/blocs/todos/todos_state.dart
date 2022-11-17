part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object?> get props => [];
}

class TodosLoading extends TodosState {}

class TodosLoaded extends TodosState {
  final List<Todo> todos;
  final Todo? lastTodo;

  const TodosLoaded({this.todos = const <Todo>[], this.lastTodo});

  @override
  List<Object?> get props => [todos, lastTodo];
}

class TodosDeleted extends TodosLoaded {
  const TodosDeleted({super.todos, super.lastTodo});
}

class TodosUpdated extends TodosLoaded {
  const TodosUpdated({super.todos, super.lastTodo});
}

class TodosAdded extends TodosLoaded {
  const TodosAdded({super.todos, super.lastTodo});
}

class TodosError extends TodosLoaded {
  const TodosError({super.todos, super.lastTodo});

}

///Example with additional variable;
/*class TodosLoaded extends TodosState {
  final String filter;

  const TodosLoaded({this.filter = '', super.todos, super.lastTodo});
  @override
  List<Object?> get props => [...super.props, filter];
}*/
