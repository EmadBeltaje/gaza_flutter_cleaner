import 'dart:io';

class DirectoryHelper {
  /// calculate the size of the given directory
  Future<double> calculateDirectorySize({required Directory directory}) async {
    // *) check if the directory exist
    if (!(await directory.exists())) return 0;

    // *) calculate the directory size
    int size = 0;
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File) {
        size += await entity.length();
      }
    }

    // *) convert bytes to megabytes
    double sizeInMB = size / (1024 * 1024);

    // *) return result
    return sizeInMB;
  }

  Future<List<Directory>> getAllSubDirectories({required Directory directory}) async {
    final subDirectories = <Directory>[];

    await for (var entity in directory.list(
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