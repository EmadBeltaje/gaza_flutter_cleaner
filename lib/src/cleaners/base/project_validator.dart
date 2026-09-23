import 'dart:io';

/// Checks whether a directory looks like a Flutter or Dart project.
class ProjectValidator {
  /// Whether [directory] contains every path in [filesToCheck].
  ///
  /// Each entry may be a file or a directory. When [filesToCheck] is empty,
  /// looks for `pubspec.yaml` and a `lib` folder.
  Future<bool> validateProject({
    required Directory directory,
    required List<File> filesToCheck,
  }) async {
    if (filesToCheck.isEmpty) {
      final pubspecFile = File('${directory.path}/pubspec.yaml');
      final libDir = Directory('${directory.path}/lib');
      return await pubspecFile.exists() && await libDir.exists();
    }

    for (final entity in filesToCheck) {
      if (await FileSystemEntity.type(entity.path) ==
          FileSystemEntityType.notFound) {
        return false;
      }
    }
    return true;
  }
}
