part of 'todos_bloc.dart';

enum TodosStatus { loading, loaded, deleted }

class TodosState extends Equatable {
  final TodosStatus status;
  final List<Todo> todos;
  final Todo? lastTodo;

  const TodosState({
    this.status = TodosStatus.loading,
    this.todos = const [],
    this.lastTodo,
  });

  TodosState copyWith({
    TodosStatus? status,
    List<Todo>? todos,
    Todo? lastTodo,
  }) =>
      TodosState(
        status: status ?? this.status,
        todos: todos ?? this.todos,
        lastTodo: lastTodo ?? this.lastTodo,
      );

  @override
  List<Object?> get props => [status, todos, lastTodo];
}
