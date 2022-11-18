import 'package:bloc_testing/data/models/model_todos.dart';
import 'package:bloc_testing/domain/repositories/abstractions/i_todos_repository.dart';

abstract class DioRepository {
/*  DioClient client;
  final String baseUrl = Environment.baseUrl;
  Dio get dio => client.dio;*/
}

class DioTodosRepository extends DioRepository implements ITodosRepository{
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
  Future<Todo> get(String id) async {
    //final res = await dio.get('$baseUrl/$id');
    //return Entity.fromJson(Todo, res.body as Map) as Todo;
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