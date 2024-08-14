import 'dart:io';

import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaner.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_command_executor.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/base/project_validator.dart';
import 'package:gaza_flutter_cleaner/src/utils/directory_helper.dart';

class FlutterCleaner extends Cleaner {
  FlutterCleaner({
    required super.directory,
    required super.cleaningCommand,
    required super.filesToCheck,
    required super.directoryHelper,
    required super.commandExecutor,
    required super.projectValidator,
  });

  factory FlutterCleaner.instance({required Directory directory, required String cleaningCommand, required List<String> filesToCheck}) {
    return FlutterCleaner(
      directory: directory,
      cleaningCommand: cleaningCommand,
      filesToCheck: filesToCheck,
      directoryHelper: DirectoryHelper(),
      commandExecutor: CommandExecutor(),
      projectValidator: ProjectValidator(),
    );
  }
}
