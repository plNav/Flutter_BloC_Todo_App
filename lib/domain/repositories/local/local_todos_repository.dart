import 'package:bloc_testing/data/models/model_todos.dart';
import 'package:bloc_testing/domain/repositories/abstractions/i_todos_repository.dart';

class LocalTodosRepository extends ITodosRepository{
  @override
  Todo create(Todo entity) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Todo get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  List<Todo> getAll() => Todo.todos;

  @override
  List<Todo> getAllWithFilter(filter) {
    // TODO: implement getAllWithFilter
    throw UnimplementedError();
  }

  @override
  Todo update(Todo entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

}