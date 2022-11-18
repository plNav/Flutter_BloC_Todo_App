import 'package:bloc_testing/domain/repositories/abstractions/i_crud_repository.dart';

import 'package:bloc_testing/data/models/model_todos.dart';

abstract class ITodosRepository extends ICrudRepository<Todo> {

  List<Todo> getAllWithFilter(dynamic filter);

}