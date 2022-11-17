part of 'todos_filter_bloc.dart';

abstract class TodosFilterEvent extends Equatable {
  const TodosFilterEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTodos extends TodosFilterEvent {
  final TodosFilterStatus todosFilterStatus;
  final List<Todo> allTodos;


  const UpdateTodos({this.todosFilterStatus = TodosFilterStatus.all, required this.allTodos});

  @override
  List<Object?> get props => [todosFilterStatus];
}

/*class UpdateFilter extends TodosFilterEvent {
  final List<Todo> allTodos;
  const UpdateFilter({required this.allTodos});

  @override
  List<Object?> get props => [];


}*/
