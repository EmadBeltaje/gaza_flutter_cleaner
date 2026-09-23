import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/flutter_cleaner/flutter_cleaner.dart';
import 'package:gaza_flutter_cleaner/src/commands/clean_flutter_command.dart';
import 'package:gaza_flutter_cleaner/src/utils/constants.dart';
import 'package:gaza_flutter_cleaner/src/utils/my_logger.dart';

/// Entry point that wires the CLI [CommandRunner] and registered commands.
class GazaCleanerBase {
  /// Parses [args] and runs the matching command.
  Future<void> run(List<String> args) async {
    final runner = CommandRunner<int>(
      Constants.executableName,
      Constants.runnerDescription,
    );
    linkCommands(runner);
    await runner.run(args);
  }

  /// Registers supported commands on [runner].
  void linkCommands(CommandRunner<int> runner) {
    final directory = Directory.current;
    final myLogger = MyLogger();
    final cleanFlutterCommand = createCleanFlutterCommand(directory, myLogger);
    runner.addCommand(cleanFlutterCommand);
  }

  /// Builds the `clean` command for [directory] using [myLogger].
  CleanFlutterCommand createCleanFlutterCommand(
    Directory directory,
    MyLogger myLogger,
  ) {
    final flutterCleaner = FlutterCleaner.instance(
      directory: directory,
      filesToCheck: Constants.flutterFilesToBeChecked,
    );

    return CleanFlutterCommand(myLogger: myLogger, cleaner: flutterCleaner);
  }
}
