// Mocks generated by Mockito 5.4.4 from annotations
// in gaza_flutter_cleaner/test/gaza_flutter_cleaner_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i2;

import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_command_executor.dart'
    as _i5;
import 'package:gaza_flutter_cleaner/src/cleaners/base/project_validator.dart'
    as _i6;
import 'package:gaza_flutter_cleaner/src/utils/directory_helper.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUri_0 extends _i1.SmartFake implements Uri {
  _FakeUri_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDirectory_1 extends _i1.SmartFake implements _i2.Directory {
  _FakeDirectory_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFileSystemEntity_2 extends _i1.SmartFake
    implements _i2.FileSystemEntity {
  _FakeFileSystemEntity_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFileStat_3 extends _i1.SmartFake implements _i2.FileStat {
  _FakeFileStat_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Directory].
///
/// See the documentation for Mockito's code generation for more information.
class MockDirectory extends _i1.Mock implements _i2.Directory {
  @override
  String get path => (super.noSuchMethod(
        Invocation.getter(#path),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#path),
        ),
        returnValueForMissingStub: _i3.dummyValue<String>(
          this,
          Invocation.getter(#path),
        ),
      ) as String);

  @override
  Uri get uri => (super.noSuchMethod(
        Invocation.getter(#uri),
        returnValue: _FakeUri_0(
          this,
          Invocation.getter(#uri),
        ),
        returnValueForMissingStub: _FakeUri_0(
          this,
          Invocation.getter(#uri),
        ),
      ) as Uri);

  @override
  _i2.Directory get absolute => (super.noSuchMethod(
        Invocation.getter(#absolute),
        returnValue: _FakeDirectory_1(
          this,
          Invocation.getter(#absolute),
        ),
        returnValueForMissingStub: _FakeDirectory_1(
          this,
          Invocation.getter(#absolute),
        ),
      ) as _i2.Directory);

  @override
  bool get isAbsolute => (super.noSuchMethod(
        Invocation.getter(#isAbsolute),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i2.Directory get parent => (super.noSuchMethod(
        Invocation.getter(#parent),
        returnValue: _FakeDirectory_1(
          this,
          Invocation.getter(#parent),
        ),
        returnValueForMissingStub: _FakeDirectory_1(
          this,
          Invocation.getter(#parent),
        ),
      ) as _i2.Directory);

  @override
  _i4.Future<_i2.Directory> create({bool? recursive = false}) =>
      (super.noSuchMethod(
        Invocation.method(
          #create,
          [],
          {#recursive: recursive},
        ),
        returnValue: _i4.Future<_i2.Directory>.value(_FakeDirectory_1(
          this,
          Invocation.method(
            #create,
            [],
            {#recursive: recursive},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Directory>.value(_FakeDirectory_1(
          this,
          Invocation.method(
            #create,
            [],
            {#recursive: recursive},
          ),
        )),
      ) as _i4.Future<_i2.Directory>);

  @override
  void createSync({bool? recursive = false}) => super.noSuchMethod(
        Invocation.method(
          #createSync,
          [],
          {#recursive: recursive},
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<_i2.Directory> createTemp([String? prefix]) => (super.noSuchMethod(
        Invocation.method(
          #createTemp,
          [prefix],
        ),
        returnValue: _i4.Future<_i2.Directory>.value(_FakeDirectory_1(
          this,
          Invocation.method(
            #createTemp,
            [prefix],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Directory>.value(_FakeDirectory_1(
          this,
          Invocation.method(
            #createTemp,
            [prefix],
          ),
        )),
      ) as _i4.Future<_i2.Directory>);

  @override
  _i2.Directory createTempSync([String? prefix]) => (super.noSuchMethod(
        Invocation.method(
          #createTempSync,
          [prefix],
        ),
        returnValue: _FakeDirectory_1(
          this,
          Invocation.method(
            #createTempSync,
            [prefix],
          ),
        ),
        returnValueForMissingStub: _FakeDirectory_1(
          this,
          Invocation.method(
            #createTempSync,
            [prefix],
          ),
        ),
      ) as _i2.Directory);

  @override
  _i4.Future<String> resolveSymbolicLinks() => (super.noSuchMethod(
        Invocation.method(
          #resolveSymbolicLinks,
          [],
        ),
        returnValue: _i4.Future<String>.value(_i3.dummyValue<String>(
          this,
          Invocation.method(
            #resolveSymbolicLinks,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<String>.value(_i3.dummyValue<String>(
          this,
          Invocation.method(
            #resolveSymbolicLinks,
            [],
          ),
        )),
      ) as _i4.Future<String>);

  @override
  String resolveSymbolicLinksSync() => (super.noSuchMethod(
        Invocation.method(
          #resolveSymbolicLinksSync,
          [],
        ),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.method(
            #resolveSymbolicLinksSync,
            [],
          ),
        ),
        returnValueForMissingStub: _i3.dummyValue<String>(
          this,
          Invocation.method(
            #resolveSymbolicLinksSync,
            [],
          ),
        ),
      ) as String);

  @override
  _i4.Future<_i2.Directory> rename(String? newPath) => (super.noSuchMethod(
        Invocation.method(
          #rename,
          [newPath],
        ),
        returnValue: _i4.Future<_i2.Directory>.value(_FakeDirectory_1(
          this,
          Invocation.method(
            #rename,
            [newPath],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Directory>.value(_FakeDirectory_1(
          this,
          Invocation.method(
            #rename,
            [newPath],
          ),
        )),
      ) as _i4.Future<_i2.Directory>);

  @override
  _i2.Directory renameSync(String? newPath) => (super.noSuchMethod(
        Invocation.method(
          #renameSync,
          [newPath],
        ),
        returnValue: _FakeDirectory_1(
          this,
          Invocation.method(
            #renameSync,
            [newPath],
          ),
        ),
        returnValueForMissingStub: _FakeDirectory_1(
          this,
          Invocation.method(
            #renameSync,
            [newPath],
          ),
        ),
      ) as _i2.Directory);

  @override
  _i4.Future<_i2.FileSystemEntity> delete({bool? recursive = false}) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {#recursive: recursive},
        ),
        returnValue:
            _i4.Future<_i2.FileSystemEntity>.value(_FakeFileSystemEntity_2(
          this,
          Invocation.method(
            #delete,
            [],
            {#recursive: recursive},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.FileSystemEntity>.value(_FakeFileSystemEntity_2(
          this,
          Invocation.method(
            #delete,
            [],
            {#recursive: recursive},
          ),
        )),
      ) as _i4.Future<_i2.FileSystemEntity>);

  @override
  void deleteSync({bool? recursive = false}) => super.noSuchMethod(
        Invocation.method(
          #deleteSync,
          [],
          {#recursive: recursive},
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Stream<_i2.FileSystemEntity> list({
    bool? recursive = false,
    bool? followLinks = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #list,
          [],
          {
            #recursive: recursive,
            #followLinks: followLinks,
          },
        ),
        returnValue: _i4.Stream<_i2.FileSystemEntity>.empty(),
        returnValueForMissingStub: _i4.Stream<_i2.FileSystemEntity>.empty(),
      ) as _i4.Stream<_i2.FileSystemEntity>);

  @override
  List<_i2.FileSystemEntity> listSync({
    bool? recursive = false,
    bool? followLinks = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #listSync,
          [],
          {
            #recursive: recursive,
            #followLinks: followLinks,
          },
        ),
        returnValue: <_i2.FileSystemEntity>[],
        returnValueForMissingStub: <_i2.FileSystemEntity>[],
      ) as List<_i2.FileSystemEntity>);

  @override
  _i4.Future<bool> exists() => (super.noSuchMethod(
        Invocation.method(
          #exists,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  bool existsSync() => (super.noSuchMethod(
        Invocation.method(
          #existsSync,
          [],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i4.Future<_i2.FileStat> stat() => (super.noSuchMethod(
        Invocation.method(
          #stat,
          [],
        ),
        returnValue: _i4.Future<_i2.FileStat>.value(_FakeFileStat_3(
          this,
          Invocation.method(
            #stat,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.FileStat>.value(_FakeFileStat_3(
          this,
          Invocation.method(
            #stat,
            [],
          ),
        )),
      ) as _i4.Future<_i2.FileStat>);

  @override
  _i2.FileStat statSync() => (super.noSuchMethod(
        Invocation.method(
          #statSync,
          [],
        ),
        returnValue: _FakeFileStat_3(
          this,
          Invocation.method(
            #statSync,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeFileStat_3(
          this,
          Invocation.method(
            #statSync,
            [],
          ),
        ),
      ) as _i2.FileStat);

  @override
  _i4.Stream<_i2.FileSystemEvent> watch({
    int? events = 15,
    bool? recursive = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #watch,
          [],
          {
            #events: events,
            #recursive: recursive,
          },
        ),
        returnValue: _i4.Stream<_i2.FileSystemEvent>.empty(),
        returnValueForMissingStub: _i4.Stream<_i2.FileSystemEvent>.empty(),
      ) as _i4.Stream<_i2.FileSystemEvent>);
}

/// A class which mocks [CommandExecutor].
///
/// See the documentation for Mockito's code generation for more information.
class MockCommandExecutor extends _i1.Mock implements _i5.CommandExecutor {
  @override
  _i4.Future<int> runCleaning({required String? directoryPath}) =>
      (super.noSuchMethod(
        Invocation.method(
          #runCleaning,
          [],
          {#directoryPath: directoryPath},
        ),
        returnValue: _i4.Future<int>.value(0),
        returnValueForMissingStub: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
}

/// A class which mocks [ProjectValidator].
///
/// See the documentation for Mockito's code generation for more information.
class MockProjectValidator extends _i1.Mock implements _i6.ProjectValidator {
  @override
  _i4.Future<bool> validateProject({
    required _i2.Directory? directory,
    required List<_i2.File>? filesToCheck,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #validateProject,
          [],
          {
            #directory: directory,
            #filesToCheck: filesToCheck,
          },
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [DirectoryHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDirectoryHelper extends _i1.Mock implements _i7.DirectoryHelper {
  @override
  _i4.Future<double> calculateDirectorySize(
          {required _i2.Directory? directory}) =>
      (super.noSuchMethod(
        Invocation.method(
          #calculateDirectorySize,
          [],
          {#directory: directory},
        ),
        returnValue: _i4.Future<double>.value(0.0),
        returnValueForMissingStub: _i4.Future<double>.value(0.0),
      ) as _i4.Future<double>);

  @override
  _i4.Future<List<_i2.Directory>> getAllSubDirectories(
          {required _i2.Directory? directory}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllSubDirectories,
          [],
          {#directory: directory},
        ),
        returnValue: _i4.Future<List<_i2.Directory>>.value(<_i2.Directory>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i2.Directory>>.value(<_i2.Directory>[]),
      ) as _i4.Future<List<_i2.Directory>>);
}
