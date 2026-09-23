import 'package:mason_logger/mason_logger.dart';

/// Thin wrapper around [Logger] with the CLI's styling.
class MyLogger {
  final Logger _logger = Logger(level: Level.info);

  /// Writes [message] as an error.
  void logError(String message) => _logger.err(message);

  /// Writes [message] as info.
  void logInfo(String message) => _logger.info(message);

  /// Writes [message] as a success line.
  void logSuccess(String message) => _logger.success(message);

  /// Starts a progress spinner with [message].
  Progress logProgress(String message) => _logger.progress(
    message,
    options: const ProgressOptions(
      animation: ProgressAnimation(frames: [' 🇵🇸 ']),
    ),
  );

  /// Writes [message] as an alert.
  void logAlert(String message) => logger.alert(
    black.wrap(backgroundMagenta.wrap(styleItalic.wrap(' $message'))),
  );

  /// Writes [message] as a warning.
  void logWarn(String message) => logger.info(yellow.wrap(message));

  /// Underlying mason [Logger].
  Logger get logger => _logger;
}
