import 'package:args/command_runner.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaner.dart';
import 'package:gaza_flutter_cleaner/src/utils/format_process_result_message.dart';
import 'package:gaza_flutter_cleaner/src/utils/my_logger.dart';

/// Shared CLI command that holds a [cleaner] and [myLogger].
abstract class BaseCommand extends Command<int> with ProcessMessageStarter {
  /// Creates a command backed by [cleaner] and [myLogger].
  BaseCommand({required this.cleaner, required this.myLogger});

  /// Cleaner that scans directories and deletes build artifacts.
  final Cleaner cleaner;

  /// Logger used to print progress and results.
  final MyLogger myLogger;
}
