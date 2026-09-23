/// Command-line tool that deletes Flutter build artifacts across projects.
///
/// Activate it globally, then run `clean` from a directory that contains
/// Flutter projects:
///
/// ```sh
/// dart pub global activate gaza_flutter_cleaner
/// gaza_flutter_cleaner clean
/// ```
///
/// See the [GitHub repository](https://github.com/EmadBeltaje/gaza_flutter_cleaner)
/// for usage details.
library;

export 'src/gaza_cleaner_base.dart';
