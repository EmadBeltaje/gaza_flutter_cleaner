import 'dart:async';
import 'dart:io';

import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_command_executor.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_result.dart';
import 'package:path/path.dart' as path;

import 'package:gaza_flutter_cleaner/src/cleaners/base/project_validator.dart';
import 'package:gaza_flutter_cleaner/src/utils/gaza_cleaner_exception.dart';
import 'package:gaza_flutter_cleaner/src/utils/directory_helper.dart';

abstract class Cleaner {
  Directory directory;
  List<String> filesToCheck;
  DirectoryHelper directoryHelper;
  CommandExecutor commandExecutor;
  ProjectValidator projectValidator;

  Cleaner({
    required this.directory,
    required this.filesToCheck,
    required this.directoryHelper,
    required this.commandExecutor,
    required this.projectValidator,
  });

  GazaCleanerExceptionType? getErrorType(int exitCode){
    if(exitCode == 0) {
      return null;
    } else if(exitCode == -2) {
      return GazaCleanerExceptionType.commandTimeout;
    } else {
      return GazaCleanerExceptionType.unknownError;
    }
  }

  Stream<CleaningResult> clean() async* {
    // Check if directory itself is a project
    bool isTheGivenDirectoryProject = await projectValidator.validateProject(
      directory: directory,
      filesToCheck: filesToCheck.map((file) => File(path.join(directory.path, file))).toList(),
    );

    // List all subdirectories
    List<Directory> directories = await directoryHelper.getAllSubDirectories(directory: directory);

    // Handle cleaning from within a project
    if (directories.isEmpty && isTheGivenDirectoryProject) {
      await commandExecutor.runCleaning(
        directoryPath: directory.path,
      );
      throw GazaCleanerException(
        errorType: GazaCleanerExceptionType.calledInsideProjectItSelf,
      );
    }

    // Handle no projects found
    if (directories.isEmpty && !isTheGivenDirectoryProject) {
      throw GazaCleanerException(
        errorType: GazaCleanerExceptionType.noProjectsFound,
      );
    }

    // Clean a project within the directory (if applicable)
    if (directories.isNotEmpty && !isTheGivenDirectoryProject) {
      await commandExecutor.runCleaning(
        directoryPath: directory.path,
      );
    }

    // List all valid projects
    List<Directory> validProjects = [];
    await Future.forEach(directories, (d) async {
      bool isValidProject = await projectValidator.validateProject(
        directory: d,
        filesToCheck: filesToCheck.map((file) => File(path.join(d.path, file))).toList(),
      );
      if (isValidProject) validProjects.add(d);
    });

    // Check if no valid projects are found
    if (validProjects.isEmpty) {
      throw GazaCleanerException(
        errorType: GazaCleanerExceptionType.noProjectsFound,
      );
    }

    // Clean valid projects and emit results as a stream
    for (var validProject in validProjects) {
      double sizeBeforeCleaning = await directoryHelper.calculateDirectorySize(
        directory: validProject,
      );

      int cleaningResult = await commandExecutor.runCleaning(
        directoryPath: validProject.path,
      );

      // *) -2 is timeout exception so we dont have to mark all the porcess
      // *) as failure we can only mark this directory as failed to be cleaned
      // if(cleaningResult != 0 && cleaningResult != -2) {
      //   throw GazaCleanerException(
      //     command: cleaningCommand,
      //     errorType: getErrorType(cleaningResult)!,
      //   );
      // }

      double sizeAfterCleaning = await directoryHelper.calculateDirectorySize(
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