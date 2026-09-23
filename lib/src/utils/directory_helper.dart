import 'dart:io';

/// File-system helpers for listing directories and measuring size.
class DirectoryHelper {
  /// Size of [directory] in megabytes, or `0` if it does not exist.
  Future<double> calculateDirectorySize({required Directory directory}) async {
    if (!(await directory.exists())) return 0;

    var size = 0;
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File) {
        size += await entity.length();
      }
    }

    final sizeInMB = size / (1024 * 1024);

    return sizeInMB;
  }

  /// Immediate child directories of [directory], without following links.
  Future<List<Directory>> getAllSubDirectories({
    required Directory directory,
  }) async {
    final subDirectories = <Directory>[];

    await for (final entity in directory.list(
      recursive: false,
      followLinks: false,
    )) {
      if (entity is Directory) {
        subDirectories.add(entity);
      }
    }

    return subDirectories;
  }
}
