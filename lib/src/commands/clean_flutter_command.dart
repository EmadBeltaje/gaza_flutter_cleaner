import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_result.dart';
import 'package:gaza_flutter_cleaner/src/commands/base_command.dart';
import 'package:gaza_flutter_cleaner/src/utils/gaza_cleaner_exception.dart';
import 'package:mason_logger/mason_logger.dart';

class CleanFlutterCommand extends BaseCommand {
  CleanFlutterCommand({required super.cleaner, required super.myLogger});

  @override
  final name = 'clean';

  @override
  String get invocation => 'gaza_flutter_cleaner clean';

  @override
  String get summary => '$invocation $description';

  @override
  String get description => 'Clean all your flutter projects that are inside the the current directory!';

  @override
  Future<int> run() async {
    Progress progress =
        myLogger.logProgress('Cleaning all the projects please wait');
    try {
      // *) Start cleaning
      final cleaningStream = cleaner.clean();

      // *) Process individual CleaningResult objects from the stream
      List<CleaningResult> results = [];
      await for (var result in cleaningStream) {
        results.add(result);
        if (result.success && result.calculateDeletedFilesSize() > 0) {
          progress.update('Successfully cleaned ${path.basename(result.directory.path)} ✅ ');
        }else if(result.success && result.calculateDeletedFilesSize() == 0) {
          progress.update('${path.basename(result.directory.path)} is already clean ✨ ');
        } else {
          progress.update('Failed to clean ${result.directory.path} 😭 ');
        }
      }

      // *) Finish progress
      progress.complete('Process done successfully, check the results below below: 🔻 ');

      // *) leave empty space to differ between result and process
      myLogger.logInfo(' ');

      // *) Format message to show it to user
      Map<String, dynamic> formattedMessage =
          formatProcessResultMessage(cleaningResults: results);

      // *) Show success messages
      if (formattedMessage['successMessage'] != null) {
        myLogger.logSuccess('${formattedMessage['successMessage']}');
      }

      // *) Show success message
      if(formattedMessage['alreadyCleanedMessage'] != null) {
        myLogger.logWarn('${formattedMessage['alreadyCleanedMessage']}');
      }

      // *) Show error messages
      if (formattedMessage['failuresMessage'] != null) {
        myLogger.logError('${formattedMessage['failuresMessage']}');
      }

      // *) show support message
      StringBuffer supportMessage = StringBuffer()
        ..writeln('Don\'t forget to support us on github & pub.dev:')
        ..writeln('https://pub.dev/packages/gaza_flutter_cleaner 👍🏻 ')
        ..writeln('https://github.com/EmadBeltaje/gaza_flutter_cleaner ⭐️ ');
      myLogger.logInfo(supportMessage.toString());

      // *) show gaza message
      myLogger.logAlert('Pray For Gaza 🇵🇸🕊️ ');

      exit(0);
    } on GazaCleanerException catch (error) {
      progress.fail(error.toString());
      exit(ExitCode.ioError.code);
    } catch (error) {
      progress.fail('Unknown error happened please contact the developer (https://www.github.com/EmadBeltaje).');
      exit(ExitCode.usage.code);
    }
  }
}
