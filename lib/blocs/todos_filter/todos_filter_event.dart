part of 'todos_filter_bloc.dart';

abstract class TodosFilterEvent extends Equatable {
  const TodosFilterEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTodos extends TodosFilterEvent {
  final TodosFilterStatus todosFilterStatus;

  const UpdateTodos({this.todosFilterStatus = TodosFilterStatus.all});

  @override
  List<Object?> get props => [todosFilterStatus];
}

class UpdateFilter extends TodosFilterEvent {
  final List<Todo> todos;
  const UpdateFilter({required this.todos});

  @override
  List<Object?> get props => [];


}
