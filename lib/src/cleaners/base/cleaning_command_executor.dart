import 'dart:io';
import 'package:path/path.dart' as path;

class CommandExecutor {
  Future<int> runCleanCommand({required String command, required String directoryPath}) async {
    // *) convert command line to list of arguments
    List<String> arguments = command.split(' ');

    const processTimeout = Duration(seconds: 20);


    // *) perform flutter clean
    try{
      bool timeout = false;
      ProcessResult result = await Process.run(
        arguments[0],
        arguments.length > 1 ? arguments.sublist(1) : [],
        workingDirectory: directoryPath,
        runInShell: true,
      ).timeout(processTimeout,onTimeout: () async {
        timeout = true;
        return ProcessResult(-1, -1, '', '');
      });


      await cleanAndroidAndIOSFolders(Platform.isWindows,directoryPath);

      return timeout ? -2 : result.exitCode;
    } catch(error) {
      return -1;
    }
  }

  /// delete the android and ios build and cache folders
  Future<bool> cleanAndroidAndIOSFolders(bool isWindows, String directoryPath) async {
    Duration timeout = Duration(seconds: 20);

    final foldersToDelete = [
      path.join(directoryPath, 'ios', 'Pods'),
      path.join(directoryPath, 'ios', 'Podfile.lock'),
      path.join(directoryPath, 'ios', 'build'),
      path.join(directoryPath, 'android', 'app', 'build'),
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
      return true;
    } catch (error) {
      print('Error cleaning folders: $error');
      return false;
    }
  }
}