import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;

/// Deletes Flutter cache and build paths under a project directory.
class CommandExecutor {
  /// Removes known build artifacts under [directoryPath].
  ///
  /// Returns `0` on success, `-2` when a delete times out, and `-1` on other
  /// failures.
  Future<int> runCleaning({required String directoryPath}) async {
    const timeout = Duration(seconds: 20);

    final pathsToDelete = [
      path.join(directoryPath, '.dart_tool'),
      path.join(directoryPath, 'pubspec.lock'),
      path.join(directoryPath, 'ios', 'Pods'),
      path.join(directoryPath, 'ios', 'Podfile.lock'),
      path.join(directoryPath, 'ios', 'build'),
      path.join(directoryPath, 'ios', '.symlinks'),
      path.join(directoryPath, 'ios', 'Flutter', 'Flutter.framework'),
      path.join(directoryPath, 'ios', 'Flutter', 'Flutter.podspec'),
      path.join(directoryPath, 'android', 'app', 'build'),
      path.join(directoryPath, 'android', '.gradle'),
      path.join(directoryPath, 'build'),
    ];

    try {
      for (final target in pathsToDelete) {
        if (await FileSystemEntity.isDirectory(target)) {
          await Directory(target).delete(recursive: true).timeout(timeout);
        } else if (await File(target).exists()) {
          await File(target).delete();
        }
      }
      return 0;
    } on TimeoutException {
      return -2;
    } catch (error) {
      return -1;
    }
  }
}
