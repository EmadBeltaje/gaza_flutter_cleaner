import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_result.dart';

/// Formats a list of [CleaningResult] objects into user-facing messages.
mixin ProcessMessageStarter {
  /// Builds success, already-clean, and failure banners from [cleaningResults].
  ///
  /// The returned map may contain `successMessage`, `alreadyCleanedMessage`,
  /// `failuresMessage`, and `totalDeletedFilesSize`.
  Map<String, dynamic> formatProcessResultMessage({
    required List<CleaningResult> cleaningResults,
  }) {
    final finalResult = <String, dynamic>{};
    final successMessage = StringBuffer();
    final failureMessage = StringBuffer();
    final alreadyCleanedMessage = StringBuffer();

    final totalCleanedFiles = cleaningResults
        .where((cr) => cr.success && cr.calculateDeletedFilesSize() > 0)
        .length;
    final totalAlreadyCleanedFiles = cleaningResults
        .where((cr) => cr.success && cr.calculateDeletedFilesSize() == 0)
        .length;
    final totalFailedToCleanFiles = cleaningResults
        .where((cr) => !cr.success)
        .length;

    var totalSizeOfDeletedFiles = 0.0;
    cleaningResults.where((cr) => cr.success).forEach((cr) {
      totalSizeOfDeletedFiles += cr.calculateDeletedFilesSize();
    });

    if (totalCleanedFiles > 0) {
      successMessage.writeln('--------------------------------------');
      successMessage.writeln(
        '$totalCleanedFiles Projects successfully cleaned ✅🇵🇸 ',
      );
      successMessage.writeln(
        '${formatedSizeMessage(totalSizeOfDeletedFiles)} 🗑️ ',
      );
      successMessage.writeln('--------------------------------------');

      finalResult['successMessage'] = successMessage.toString();
    }

    if (totalAlreadyCleanedFiles > 0) {
      alreadyCleanedMessage.writeln('--------------------------------------');
      alreadyCleanedMessage.writeln(
        '$totalAlreadyCleanedFiles Projects were already clean ✨ ',
      );
      alreadyCleanedMessage.writeln('--------------------------------------');

      finalResult['alreadyCleanedMessage'] = alreadyCleanedMessage.toString();
    }

    if (totalFailedToCleanFiles > 0) {
      failureMessage.writeln('--------------------------------------');
      failureMessage.writeln(
        '$totalFailedToCleanFiles Projects failed to be cleaned ❌ ',
      );
      failureMessage.writeln('--------------------------------------');

      finalResult['failuresMessage'] = failureMessage.toString();
    }

    finalResult['totalDeletedFilesSize'] = totalSizeOfDeletedFiles;

    return finalResult;
  }

  /// Human-readable size string for [sizeInMB].
  String formatedSizeMessage(double sizeInMB) {
    if (sizeInMB >= 1024) {
      final sizeInGB = sizeInMB / 1024;
      return 'Total deleted cache files = ${sizeInGB.toStringAsFixed(2)}GB';
    } else {
      return 'Total deleted cache files = ${sizeInMB.toStringAsFixed(2)}MB';
    }
  }
}
