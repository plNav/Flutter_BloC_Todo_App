import 'package:flutter/material.dart';

const String END = '\x1B[0m';

const String ERROR = '\u001b[31;1m';
const String RED = '\x1B[31m';

const String SUCCESS = '\u001b[32;1m';
const String GREEN = '\x1B[32m';

const String WARNING = '\u001b[33;1m';
const String YELLOW = '\x1B[33m';

const String PURPLE_B = '\u001b[35;1m';
const String PURPLE = '\x1B[35m';

const String BLUE_B = '\u001b[34;1m';
const String BLUE = '\x1B[34m';

const String CYAN_B = '\u001b[36;1m';
const String CYAN = '\x1B[36m';

const String SYMBOLS = '€!¡?¿@#%&*(){}-_=<>';
int count = 0;

///Show console msg with color.
///
///[color] constants declared in <b>utils > console_printer.dart</b>
///[printLabel] default false, if true [printCWarning] before [msg].
printC(String color, String msg, {bool printLabel = false}) {
  if (printLabel) {
    printCWarning();
  }
  print('${count < 10 ? '0${count++}' : count++} $color $msg $END');
}

///Show console msg with color and Stacktrace.
///
///[color] constants declared in <b>utils > console_printer.dart</b>
///[printLabel] default false, if true [printCWarning] before [msg].
printStacktrace(String color, String msg, {bool printLabel = false}) {
  if (printLabel) {
    printCWarning();
  }
  final body = '$color $msg $END';
  print('${count < 10 ? '0${count++}' : count++} $body ${StackTrace.current.toString()}');
}

///Prints visible multiline WARNING with colors in console.
printCWarning() {
  print('\n');
  print('$WARNING*********************************$END');
  print('$WARNING**$ERROR    *      WARNING      *   $END $WARNING**$END');
  print('$WARNING*********************************$END');
  print('\n');
}

///Shows different colors for [printC] and prints [printCWarning].
printCTest() {
  printCWarning();
  print('$ERROR TE\$T $SYMBOLS ERROR $END');
  print('$SUCCESS TE\$T $SYMBOLS SUCCESS $END');
  print('$WARNING TE\$T $SYMBOLS WARNING $END');
  print('$RED TE\$T $SYMBOLS RED $END');
  print('$GREEN TE\$T $SYMBOLS GREEN $END');
  print('$YELLOW TE\$T $SYMBOLS YELLOW $END');
  print('$BLUE_B TE\$T $SYMBOLS BLUE_B $END');
  print('$BLUE TE\$T $SYMBOLS BLUE $END');
  print('$CYAN_B TE\$T $SYMBOLS CYAN_B $END');
  print('$CYAN TE\$T $SYMBOLS CYAN $END');
  print('$PURPLE_B TE\$T $SYMBOLS PURPLE_B $END');
  print('$PURPLE TE\$T $SYMBOLS PURPLE $END');
  printCWarning();
}

///Prints Ratio, With & Height for the currentScreen by [context] labelled by [screen].
void printCScreenSize(BuildContext context, String screen) {
  printC(BLUE, 'Screen rebuilt [$screen]');
  printC(CYAN, 'Ratio  => ${MediaQuery.of(context).size.aspectRatio}');
  printC(CYAN, 'Width  => ${MediaQuery.of(context).size.width}');
  printC(CYAN, 'Height => ${MediaQuery.of(context).size.height} $END \n.');
}
