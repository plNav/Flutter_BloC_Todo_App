part of 'todos_filter_bloc.dart';

enum TodosFilterStatus { all, completed, cancelled, pending }

class TodosFilterState extends Equatable {
  final TodosFilterStatus status;
  final List<Todo> todosFiltered;
  final List<Todo> allTodos;

  const TodosFilterState({
    this.status = TodosFilterStatus.all,
    this.todosFiltered = const [],
    this.allTodos = const [],
  });

  TodosFilterState copyWith({
    TodosFilterStatus? status,
    List<Todo>? todosFiltered,
    List<Todo>? allTodos,
  }) =>
      TodosFilterState(
        status: status ?? this.status,
        todosFiltered: todosFiltered ?? this.todosFiltered,
        allTodos: allTodos ?? this.allTodos,
      );

  @override
  List<Object?> get props => [status, todosFiltered];
}
