import 'package:bloc_testing/domain/blocs/todos/todos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class InfoPopup {
  static void dismiss({required BuildContext context}) => Navigator.of(context).pop();

  static void show({
    required BuildContext context,
    required List<String> text,
    bool isError = true,
  }) {
    const separator = SizedBox(height: 15);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            context.read<TodosBloc>().add(const TodoErrorDone());
            return true;
          },
          child: AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            content: Flex(
              mainAxisSize: MainAxisSize.min,
              direction: Axis.vertical,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 2, right: 4),
                      child: isError
                          ? Icon(FontAwesomeIcons.circleXmark,
                              color: Theme.of(context).colorScheme.error, size: 18)
                          : Icon(FontAwesomeIcons.circleInfo,
                              color: Theme.of(context).colorScheme.primary, size: 18),
                    ),
                    separator,
                    Text(
                      isError ? 'ERROR' : 'INFORMACIÓN',
                      style: TextStyle(
                        color: isError
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                separator,
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: text
                          .map((e) => Text(e,
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 18)))
                          .toList(),
                    ),
                  ),
                ),
                separator,
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<TodosBloc>().add(const TodoErrorDone());
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('OK',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
