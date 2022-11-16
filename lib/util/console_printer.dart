import 'package:flutter/cupertino.dart';

const String END     = '\x1B[0m';
const String ERROR   = '\x1B[31m';
const String SUCCESS = '\x1B[32m';
const String WARNING = '\x1B[33m';
const String BLUE    = '\x1B[34m';
const String PURPLE  = '\x1B[35m';
const String CYAN    = '\x1B[36m';

///Show console msg with color. Color constants
///declared in <b>utils > console_printer.dart</b>
void printC(String color, String msg) => print('$color $msg $END');

//TODO UPDATE printC TO KEEP A LIST OF LOGS TO UPLOAD

void printScreenSizeOnRebuild(BuildContext context, String screen) {
  printC(BLUE, 'Screen rebuilt [$screen]');
  printC(CYAN, 'Ratio  => ${MediaQuery.of(context).size.aspectRatio}');
  printC(CYAN, 'Width  => ${MediaQuery.of(context).size.width}');
  printC(CYAN, 'Height => ${MediaQuery.of(context).size.height} $END \n.');
}