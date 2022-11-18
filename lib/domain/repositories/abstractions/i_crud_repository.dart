import 'dart:async';

abstract class ICrudRepository<T> {
  FutureOr<List<T>> getAll();

  FutureOr<T> get(String id);

  T create(T entity);

  T update(T entity);

  delete(String id);
}
