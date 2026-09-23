import 'dart:io';

import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaner.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_command_executor.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/base/project_validator.dart';
import 'package:gaza_flutter_cleaner/src/utils/directory_helper.dart';

/// Flutter-specific [Cleaner] that deletes common build and cache paths.
class FlutterCleaner extends Cleaner {
  /// Creates a cleaner with injected collaborators.
  FlutterCleaner({
    required super.directory,
    required super.filesToCheck,
    required super.directoryHelper,
    required super.commandExecutor,
    required super.projectValidator,
  });

  /// Builds a [FlutterCleaner] with default helpers for [directory].
  ///
  /// [filesToCheck] are the relative paths that identify a Flutter project.
  factory FlutterCleaner.instance({
    required Directory directory,
    required List<String> filesToCheck,
  }) {
    return FlutterCleaner(
      directory: directory,
      filesToCheck: filesToCheck,
      directoryHelper: DirectoryHelper(),
      commandExecutor: CommandExecutor(),
      projectValidator: ProjectValidator(),
    );
  }
}
