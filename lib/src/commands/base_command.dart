import 'package:args/command_runner.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaner.dart';
import 'package:gaza_flutter_cleaner/src/utils/format_process_result_message.dart';
import 'package:gaza_flutter_cleaner/src/utils/my_logger.dart';

abstract class BaseCommand extends Command<int> with ProcessMessageStarter {
  final Cleaner cleaner;
  final MyLogger myLogger;

  BaseCommand({required this.cleaner, required this.myLogger});
}