import 'dart:io';

/// Outcome of cleaning a single project [directory].
class CleaningResult {
  /// Creates a result for [directory].
  CleaningResult({
    required this.directory,
    required this.sizeBeforeCleaning,
    required this.sizeAfterCleaning,
    required this.success,
  });

  /// Builds a failed result with zero sizes for [directory].
  factory CleaningResult.failure({required Directory directory}) {
    return CleaningResult(
      directory: directory,
      sizeBeforeCleaning: 0,
      sizeAfterCleaning: 0,
      success: false,
    );
  }

  /// Project directory that was cleaned.
  final Directory directory;

  /// Directory size in megabytes before cleaning.
  final double sizeBeforeCleaning;

  /// Directory size in megabytes after cleaning.
  final double sizeAfterCleaning;

  /// Whether the delete pass completed without an error.
  final bool success;

  /// Size in megabytes removed from [directory].
  num calculateDeletedFilesSize() => sizeBeforeCleaning - sizeAfterCleaning;
}
