import 'package:mason_logger/mason_logger.dart';

class MyLogger {
  final Logger _logger = Logger(
    level: Level.info,
  );

  logError(String message) => _logger.err(message);

  logInfo(String message) => _logger.info(message);

  logSuccess(String message) => _logger.success(message);

  Progress logProgress(String message) => _logger.progress(
        message,
        options: ProgressOptions(
          animation: ProgressAnimation(
            frames: [' 🇵🇸 '],
          ),
        ),
      );

  logAlert(String message) => logger.alert(black.wrap(backgroundMagenta.wrap(styleItalic.wrap(" $message"),),));

  logWarn(String message) => logger.info(yellow.wrap(message));

  Logger get logger => _logger;
}
