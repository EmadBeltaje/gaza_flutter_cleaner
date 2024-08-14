import 'dart:io';

class CleaningResult {
  final Directory directory;
  final double sizeBeforeCleaning;
  final double sizeAfterCleaning;
  final bool success;

  CleaningResult({
    required this.directory,
    required this.sizeBeforeCleaning,
    required this.sizeAfterCleaning,
    required this.success,
  });

  // factory class for failure with normal values
  factory CleaningResult.failure({required Directory directory}) {
    return CleaningResult(
      directory: directory,
      sizeBeforeCleaning: 0,
      sizeAfterCleaning: 0,
      success: false,
    );
  }

  num calculateDeletedFilesSize() => sizeBeforeCleaning - sizeAfterCleaning;

}