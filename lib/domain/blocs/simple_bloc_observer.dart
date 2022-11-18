import 'package:bloc_testing/util/console_printer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    printC(blue, 'Observer onEvent => ${bloc.runtimeType} -> ${event.runtimeType}');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    printC(blue, 'Observer onError => ${bloc.runtimeType}');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    printC(blue,
        'Observer onTransition => ${bloc.runtimeType} -> ${transition.event.runtimeType}');
    super.onTransition(bloc, transition);
  }
}
