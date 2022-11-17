import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    //printC(WARNING, 'Observer onEvent => ${bloc.runtimeType}');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
   // printC(ERROR, 'Observer onError => ${bloc.runtimeType}');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
   // printC(BLUE, 'Observer onTransition => ${bloc.runtimeType}');
    super.onTransition(bloc, transition);
  }
}
