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

int count = 0;

///Show console msg with color. Color constants
///declared in <b>utils > console_printer.dart</b>
void printC(String color, String msg, {bool printLabel = false}) {
  if(printLabel){
    printWarning();
  }
  print('$color ${count < 10 ? '0${count++}' : count++} $msg $END');
}

void printStacktrace(String color, String msg, {bool printLabel = false}) {
  if(printLabel){
    printWarning();
  }
  print('$color ${count < 10 ? '0${count++}' : count++} $msg $END ${StackTrace.current.toString()}');
}

void printWarning(){
  print('$WARNING*********************************$END');
  print('$WARNING**$ERROR    *      WARNING      *   $END $WARNING**$END');
  print('$WARNING*********************************$END');
}

void printTest() {
  print('$ERROR TE\$T ERROR $END');
  print('$SUCCESS TE\$T SUCCESS $END');
  print('$WARNING TE\$T WARNING $END');
  print('$RED TE\$T RED $END');
  print('$GREEN TE\$T GREEN $END');
  print('$YELLOW TE\$T YELLOW $END');
  print('$BLUE_B TE\$T BLUE_B $END');
  print('$BLUE TE\$T BLUE $END');
  print('$CYAN_B TE\$T CYAN_B $END');
  print('$CYAN TE\$T CYAN $END');
  print('$PURPLE_B TE\$T PURPLE_B $END');
  print('$PURPLE TE\$T PURPLE $END');
  printWarning();
}

void printScreenSizeOnRebuild(BuildContext context, String screen) {
  printC(BLUE, 'Screen rebuilt [$screen]');
  printC(CYAN, 'Ratio  => ${MediaQuery.of(context).size.aspectRatio}');
  printC(CYAN, 'Width  => ${MediaQuery.of(context).size.width}');
  printC(CYAN, 'Height => ${MediaQuery.of(context).size.height} $END \n.');
}
