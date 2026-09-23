import 'dart:async';
import 'dart:io';

import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_command_executor.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_result.dart';
import 'package:path/path.dart' as path;

import 'package:gaza_flutter_cleaner/src/cleaners/base/project_validator.dart';
import 'package:gaza_flutter_cleaner/src/utils/gaza_cleaner_exception.dart';
import 'package:gaza_flutter_cleaner/src/utils/directory_helper.dart';

/// Discovers Flutter-like projects under [directory] and cleans each one.
abstract class Cleaner {
  /// Creates a cleaner that operates on [directory].
  Cleaner({
    required this.directory,
    required this.filesToCheck,
    required this.directoryHelper,
    required this.commandExecutor,
    required this.projectValidator,
  });

  /// Root directory the user invoked the CLI from.
  Directory directory;

  /// Relative file or folder names that mark a valid project.
  List<String> filesToCheck;

  /// Helper used to list subdirectories and measure size.
  DirectoryHelper directoryHelper;

  /// Runs the delete pass for a single project path.
  CommandExecutor commandExecutor;

  /// Decides whether a directory is a project.
  ProjectValidator projectValidator;

  /// Maps a process [exitCode] to a [GazaCleanerExceptionType], or `null` on success.
  GazaCleanerExceptionType? getErrorType(int exitCode) {
    if (exitCode == 0) {
      return null;
    } else if (exitCode == -2) {
      return GazaCleanerExceptionType.commandTimeout;
    } else {
      return GazaCleanerExceptionType.unknownError;
    }
  }

  /// Yields a [CleaningResult] for each valid project under [directory].
  ///
  /// Throws a [GazaCleanerException] when the current folder is itself a
  /// project, or when no projects are found.
  Stream<CleaningResult> clean() async* {
    final isTheGivenDirectoryProject = await projectValidator.validateProject(
      directory: directory,
      filesToCheck: filesToCheck
          .map((file) => File(path.join(directory.path, file)))
          .toList(),
    );

    final directories = await directoryHelper.getAllSubDirectories(
      directory: directory,
    );

    if (directories.isEmpty && isTheGivenDirectoryProject) {
      await commandExecutor.runCleaning(directoryPath: directory.path);
      throw const GazaCleanerException(
        errorType: GazaCleanerExceptionType.calledInsideProjectItSelf,
      );
    }

    if (directories.isEmpty && !isTheGivenDirectoryProject) {
      throw const GazaCleanerException(
        errorType: GazaCleanerExceptionType.noProjectsFound,
      );
    }

    if (directories.isNotEmpty && !isTheGivenDirectoryProject) {
      await commandExecutor.runCleaning(directoryPath: directory.path);
    }

    final validProjects = <Directory>[];
    await Future.forEach(directories, (d) async {
      final isValidProject = await projectValidator.validateProject(
        directory: d,
        filesToCheck: filesToCheck
            .map((file) => File(path.join(d.path, file)))
            .toList(),
      );
      if (isValidProject) validProjects.add(d);
    });

    if (validProjects.isEmpty) {
      throw const GazaCleanerException(
        errorType: GazaCleanerExceptionType.noProjectsFound,
      );
    }

    for (final validProject in validProjects) {
      final sizeBeforeCleaning = await directoryHelper.calculateDirectorySize(
        directory: validProject,
      );

      final cleaningResult = await commandExecutor.runCleaning(
        directoryPath: validProject.path,
      );

      final sizeAfterCleaning = await directoryHelper.calculateDirectorySize(
        directory: validProject,
      );

      yield CleaningResult(
        directory: validProject,
        success: cleaningResult == 0,
        sizeBeforeCleaning: sizeBeforeCleaning,
        sizeAfterCleaning: sizeAfterCleaning,
      );
    }
  }
}
