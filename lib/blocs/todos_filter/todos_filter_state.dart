part of 'todos_filter_bloc.dart';

enum TodosFilterStatus { all, completed, cancelled, pending }

class TodosFilterState extends Equatable {
  final TodosFilterStatus status;
  final List<Todo> todosFiltered;

  const TodosFilterState({
    this.status = TodosFilterStatus.all,
    this.todosFiltered = const [],
  });

  TodosFilterState copyWith({
    TodosFilterStatus? status,
    List<Todo>? todosFiltered,
  }) =>
      TodosFilterState(
        status: status ?? this.status,
        todosFiltered: todosFiltered ?? this.todosFiltered,
      );

  @override
  List<Object?> get props => [status, todosFiltered];
}
