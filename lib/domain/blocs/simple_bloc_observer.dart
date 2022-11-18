import 'package:bloc/bloc.dart';
import 'package:bloc_testing/util/console_printer.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    printC(BLUE, 'Observer onEvent => ${bloc.runtimeType} -> ${event.runtimeType}');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    printC(BLUE, 'Observer onError => ${bloc.runtimeType}');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    printC(BLUE,
        'Observer onTransition => ${bloc.runtimeType} -> ${transition.event.runtimeType}');
    super.onTransition(bloc, transition);
  }
}
