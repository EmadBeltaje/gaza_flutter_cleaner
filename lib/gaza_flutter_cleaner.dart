/// A powerful command-line tool to clean up all your Flutter projects at once,
/// freeing up disk space and keeping your development environment tidy.
///
/// Gaza Flutter Cleaner allows you to effortlessly run clean commands across
/// multiple Flutter projects, helping you maintain a streamlined workspace
/// with just a single command.
///
/// # Features
/// - Clean all Flutter projects within a directory with one command.
/// - Save disk space by removing unnecessary build artifacts.
/// - Simple and easy to use.
///
/// # Getting Started
/// Install the package globally and run the cleaner command in your desired directory.
///
/// ```bash
/// dart pub global activate gaza_flutter_cleaner
/// gaza_flutter_cleaner clean
/// # Run the cleaner with the fvm flag if you use Flutter Version Management (FVM)
/// gaza_flutter_cleaner clean --fvm
/// ```
///
/// For more detailed usage instructions and options, visit the [GitHub repository](https://github.com/your-repo-url).
library;

export 'src/gaza_cleaner_base.dart';