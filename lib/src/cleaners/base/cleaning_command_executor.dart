import 'dart:io';
import 'package:path/path.dart' as path;

class CommandExecutor {
  Future<int> runCleaning({required String directoryPath}) async {
    // *) timeout
    Duration timeout = Duration(seconds: 20);

    // *) check platform
    bool isWindows = Platform.isWindows;

    // *) folders to be deleted
    final foldersToDelete = [
      path.join(directoryPath, '.dart_tool'),
      path.join(directoryPath, '.pubspec.lock'),
      path.join(directoryPath, 'ios', 'Pods'),
      path.join(directoryPath, 'ios', 'Podfile.lock'),
      path.join(directoryPath, 'ios', 'build'),
      path.join(directoryPath, 'ios', '.symlinks'),
      path.join(directoryPath, 'ios', '.Flutter','Flutter.framework'),
      path.join(directoryPath, 'ios', '.Flutter','Flutter.podspec'),
      path.join(directoryPath, 'android', 'app', 'build'),
      path.join(directoryPath, 'android', '.gradle'),
      path.join(directoryPath, 'build'),
    ];

    try {
      for (final folder in foldersToDelete) {
        if (await FileSystemEntity.isDirectory(folder)) {
          final command = isWindows ? 'rmdir' : 'rm';
          final args = isWindows ? ['/s', '/q'] : ['-rf'];
          await Process.run(command, [...args, folder], workingDirectory: directoryPath).timeout(timeout);
        } else if (await File(folder).exists()) {
          await File(folder).delete();
        }
      }
      return 0;
    } catch (error) {
      return -1;
    }
  }
}