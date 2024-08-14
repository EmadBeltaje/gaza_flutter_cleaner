import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_result.dart';

mixin ProcessMessageStarter {
  /// print the final message that will be displayed to the user
  /// message will contain all the projects that got cleaned successfully
  /// with all details of how many cache got deleted from each file along with
  /// total it also has all the projects that failed to be cleaned
  Map<String, dynamic> formatProcessResultMessage({
    required List<CleaningResult> cleaningResults,
  }) {
    final finalResult = <String,dynamic>{};
    final successMessage = StringBuffer();
    final failureMessage = StringBuffer();
    final alreadyCleanedMessage = StringBuffer();

    int totalCleanedFiles = cleaningResults.where((cr) => cr.success && cr.calculateDeletedFilesSize() > 0).length;
    int totalAlreadyCleanedFiles = cleaningResults.where((cr) => cr.success && cr.calculateDeletedFilesSize() == 0).length;
    int totalFailedToCleanFiles = cleaningResults.where((cr) => !cr.success).length;

    double totalSizeOfDeletedFiles = 0;
    cleaningResults.where((cr) => cr.success).forEach((cr){
      if(cr.success) totalSizeOfDeletedFiles += cr.calculateDeletedFilesSize();
    });

    if(totalCleanedFiles > 0) {
      successMessage.writeln('--------------------------------------');
      successMessage.writeln('$totalCleanedFiles Projects successfully cleaned ✅🇵🇸 ');
      successMessage.writeln('${formatedSizeMessage(totalSizeOfDeletedFiles)} 🗑️ ');
      successMessage.writeln('--------------------------------------');

      finalResult['successMessage'] = successMessage.toString();
    }

    if(totalAlreadyCleanedFiles > 0) {
      alreadyCleanedMessage.writeln('--------------------------------------');
      alreadyCleanedMessage.writeln('$totalAlreadyCleanedFiles Projects were already clean ✨ ');
      alreadyCleanedMessage.writeln('--------------------------------------');

      finalResult['alreadyCleanedMessage'] = alreadyCleanedMessage.toString();
    }

    if(totalFailedToCleanFiles > 0) {
      failureMessage.writeln('--------------------------------------');
      failureMessage.writeln('$totalFailedToCleanFiles Projects failed to be cleaned ❌ ');
      failureMessage.writeln('--------------------------------------');

      finalResult['failuresMessage'] = failureMessage.toString();
    }

    finalResult['totalDeletedFilesSize'] = totalSizeOfDeletedFiles;

    return finalResult;
  }

  String formatedSizeMessage(double sizeInMB) {
    if (sizeInMB >= 1024) {
      double sizeInGB = sizeInMB / 1024;
      return 'Total deleted cache files = ${sizeInGB.toStringAsFixed(2)}GB ️ ';
    } else {
      return 'Total deleted cache files = ${sizeInMB.toStringAsFixed(2)}MB  ';
    }
  }
}