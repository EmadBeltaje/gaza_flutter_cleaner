/// Failure raised while discovering or cleaning projects.
class GazaCleanerException implements Exception {
  /// Creates an exception for [errorType].
  const GazaCleanerException({required this.errorType});

  /// Kind of failure that occurred.
  final GazaCleanerExceptionType errorType;

  @override
  String toString() {
    return switch (errorType) {
      GazaCleanerExceptionType.commandNotFound =>
        'Cleaning command was not found!',
      GazaCleanerExceptionType.commandTimeout => 'Took so much time to finish!',
      GazaCleanerExceptionType.emptyDirectory => 'The directory is empty!',
      GazaCleanerExceptionType.noProjectsFound =>
        'No projects found in the sub-directories.',
      GazaCleanerExceptionType.calledInsideProjectItSelf =>
        'Note: we cleaned this project but for better use run it on the root folder of your projects so it clean all the projects in one time!',
      GazaCleanerExceptionType.unknownError =>
        'Something went wrong please contact the developer (https://www.github.com/EmadBeltaje).',
    };
  }
}

/// Categories of [GazaCleanerException].
enum GazaCleanerExceptionType {
  /// Cleaning command was missing on the system.
  commandNotFound,

  /// Target directory had no entries.
  emptyDirectory,

  /// No Flutter projects were found under the current directory.
  noProjectsFound,

  /// Command was run inside a single project instead of a projects folder.
  calledInsideProjectItSelf,

  /// A delete pass exceeded the timeout.
  commandTimeout,

  /// Failure that does not match a more specific type.
  unknownError,
}
