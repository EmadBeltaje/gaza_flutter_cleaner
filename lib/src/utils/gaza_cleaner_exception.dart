class GazaCleanerException implements Exception {
  final GazaCleanerExceptionType errorType;
  const GazaCleanerException({required this.errorType});

  @override
  String toString(){
    switch (errorType) {
      case GazaCleanerExceptionType.commandTimeout:
        return 'Took so much time to finish!';
      case GazaCleanerExceptionType.emptyDirectory:
        return 'The directory is empty!';
      case GazaCleanerExceptionType.noProjectsFound:
        return 'No projects found in the sub-directories.';
      case GazaCleanerExceptionType.calledInsideProjectItSelf:
        return 'Note: we cleaned this project but for better use run it on the root folder of your projects so it clean all the projects in one time!';
      case GazaCleanerExceptionType.unknownError:
        return 'Something went wrong please contact the developer (https://www.github.com/EmadBeltaje).';
      default:
        return 'Something went wrong please contact the developer (https://www.github.com/EmadBeltaje).';
    }
  }
}

enum GazaCleanerExceptionType {
  // command not found (the cleaning command was not found)
  commandNotFound,
  // empty directory
  emptyDirectory,
  // no projects found on the listed directories
  noProjectsFound,
  // user run the action while he is inside project not a directory of projects
  calledInsideProjectItSelf,
  // cleaning some project took too much time
  commandTimeout,
  // other type of error
  unknownError,
}