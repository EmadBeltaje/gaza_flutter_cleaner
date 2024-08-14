import 'dart:io';

class ProjectValidator {
  /// check if the given directory have the given files to check if they exist
  /// that mean the project is valid for example (pubspec.yaml, lib) for flutter
  /// will return true if the pubspec.yaml and lib exist cuz that means its
  /// real flutter project not a normal directory
  Future<bool> validateProject(
      {required Directory directory, required List<File> filesToCheck}) async {
    final pubspecFile = File('${directory.path}/pubspec.yaml');
    final libDir = Directory('${directory.path}/lib');
    bool pubspecFileExists = await pubspecFile.exists();
    bool libDirExists = await libDir.exists();
    return pubspecFileExists && libDirExists;
  }
}
