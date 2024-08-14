import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/flutter_cleaner/flutter_cleaner.dart';
import 'package:gaza_flutter_cleaner/src/commands/clean_flutter_command.dart';
import 'package:gaza_flutter_cleaner/src/utils/constants.dart';
import 'package:gaza_flutter_cleaner/src/utils/my_logger.dart';


class GazaCleanerBase {
  static final GazaCleanerBase _instance = GazaCleanerBase._internal();

  factory GazaCleanerBase() => _instance;

  GazaCleanerBase._internal();

  run(List<String> args) async {
    CommandRunner runner = CommandRunner<int>(Constants.executableName, Constants.runnerDescription);
    linkCommands(runner);
    runner.run(args);
  }

  linkCommands(CommandRunner runner) {
    // *) current directory (where user performed command)
    Directory directory = Directory.current;

    // *) help with logging events
    MyLogger myLogger = MyLogger();

    // *) create flutter clean sub-command
    CleanFlutterCommand cleanFlutterCommand = createCleanFlutterCommand(directory,myLogger);

    // *) start the runner..
    runner.addCommand(cleanFlutterCommand);
  }


  /// generate clean flutter command
  CleanFlutterCommand createCleanFlutterCommand(Directory directory,MyLogger myLogger) {
    // *) create the cleaner
    FlutterCleaner flutterCleaner = FlutterCleaner.instance(
      directory: directory,
      cleaningCommand: Constants.flutterCleanCommand,
      filesToCheck: Constants.flutterFilesToBeChecked,
    );

    // *) create the command
    return CleanFlutterCommand(
      myLogger: myLogger,
      cleaner: flutterCleaner,
    );
  }
}