import 'dart:io';

import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_command_executor.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/base/cleaning_result.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/base/project_validator.dart';
import 'package:gaza_flutter_cleaner/src/cleaners/flutter_cleaner/flutter_cleaner.dart';
import 'package:gaza_flutter_cleaner/src/utils/directory_helper.dart';
import 'package:gaza_flutter_cleaner/src/utils/gaza_cleaner_exception.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'gaza_flutter_cleaner_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Directory>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<CommandExecutor>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ProjectValidator>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DirectoryHelper>(onMissingStub: OnMissingStub.returnDefault),
])
main() {
  late MockDirectoryHelper mockDirectoryHelper;
  late MockProjectValidator mockProjectValidator;
  late MockCommandExecutor mockCommandExecutor;
  late MockDirectory directory;

  setUp(() {
    mockDirectoryHelper = MockDirectoryHelper();
    mockProjectValidator = MockProjectValidator();
    mockCommandExecutor = MockCommandExecutor();
    directory = MockDirectory();
  });

  test(
      'test if user run the command from inside a project it self not from the root folder that contain all the projects, so in that case we must clean the project it self and throw exception to tell user how to use the command the right way the error type should be calledInsideProjectItSelf',
      () async {
    when(
      mockProjectValidator.validateProject(
        directory: anyNamed('directory'),
        filesToCheck: anyNamed('filesToCheck'),
      ),
    ).thenAnswer((_) async => true);

    when(
      mockDirectoryHelper.getAllSubDirectories(
        directory: anyNamed('directory'),
      ),
    ).thenAnswer((_) async => ([]));

    // Simulate command failure
    when(
      mockCommandExecutor.runCleanCommand(
        command: anyNamed('command'),
        directoryPath: anyNamed('directoryPath'),
      ),
    ).thenAnswer((_) async => 0);

    final flutterCleaner = FlutterCleaner(
      directory: directory,
      cleaningCommand: 'flutter clean',
      filesToCheck: [],
      directoryHelper: mockDirectoryHelper,
      commandExecutor: mockCommandExecutor,
      projectValidator: mockProjectValidator,
    );

    try {
      final results = <CleaningResult>[];
      await for (var result in flutterCleaner.clean()) {
        results.add(result);
      }
      fail('Expected GazaCleanerException to be thrown');
    } on GazaCleanerException catch (e) {
      expect(e, isA<GazaCleanerException>());
      expect(e.errorType, GazaCleanerExceptionType.calledInsideProjectItSelf);
    }

    // Verify that runCleanCommand was called at least once with any arguments
    verify(
      mockCommandExecutor.runCleanCommand(
        command: anyNamed('command'),
        directoryPath: anyNamed('directoryPath'),
      ),
    ).called(1);
  });

  test(
      'test if user run the command from inside a project it self not from the root folder than contain all the projects so in this case should clean the project it self and throw exception, but in this case we will fake that we tried to clean but got error during cleaning so it should throw GazaCleanerException with error type cleaningError',
      () async {
    when(
      mockProjectValidator.validateProject(
        directory: anyNamed('directory'),
        filesToCheck: anyNamed('filesToCheck'),
      ),
    ).thenAnswer((_) async => true);

    when(
      mockDirectoryHelper.getAllSubDirectories(
        directory: anyNamed('directory'),
      ),
    ).thenAnswer((_) async => ([]));

    // Simulate command failure
    when(
      mockCommandExecutor.runCleanCommand(
        command: anyNamed('command'),
        directoryPath: anyNamed('directoryPath'),
      ),
    ).thenAnswer((_) async => -1);

    final flutterCleaner = FlutterCleaner(
      directory: directory,
      cleaningCommand: 'flutter clean',
      filesToCheck: [],
      directoryHelper: mockDirectoryHelper,
      commandExecutor: mockCommandExecutor,
      projectValidator: mockProjectValidator,
    );

    try {
      final results = <CleaningResult>[];
      await for (var result in flutterCleaner.clean()) {
        results.add(result);
      }
      fail('Expected GazaCleanerException to be thrown');
    } on GazaCleanerException catch (e) {
      expect(e, isA<GazaCleanerException>());
      expect(e.errorType, GazaCleanerExceptionType.cleaningError);
    }

    // Verify that runCleanCommand was called at least once with any arguments
    verify(
      mockCommandExecutor.runCleanCommand(
        command: anyNamed('command'),
        directoryPath: anyNamed('directoryPath'),
      ),
    ).called(1);
  });

  test('test if no projects found', () async {
    when(
      mockProjectValidator.validateProject(
        directory: anyNamed('directory'),
        filesToCheck: anyNamed('filesToCheck'),
      ),
    ).thenAnswer((_) async => false); // Simulate no valid projects

    when(
      mockDirectoryHelper.getAllSubDirectories(
        directory: anyNamed('directory'),
      ),
    ).thenAnswer(
      (_) async => ([]),
    );

    final flutterCleaner = FlutterCleaner(
      directory: directory,
      cleaningCommand: 'flutter clean',
      filesToCheck: [],
      directoryHelper: mockDirectoryHelper,
      commandExecutor: mockCommandExecutor,
      projectValidator: mockProjectValidator,
    );

    expectLater(
      flutterCleaner.clean(),
      emitsError(
        isA<GazaCleanerException>().having(
          (e) => e.errorType,
          'errorType',
          GazaCleanerExceptionType.noProjectsFound,
        ),
      ),
    );
  });

  test('test successful cleaning with multiple projects using stream',
      () async {
    // Simulate two valid projects
    when(
      mockDirectoryHelper.getAllSubDirectories(
        directory: anyNamed('directory'),
      ),
    ).thenAnswer(
      (_) async => [
        MockDirectory(),
        MockDirectory(),
      ],
    );
    when(
      mockProjectValidator.validateProject(
        filesToCheck: anyNamed('filesToCheck'),
        directory: anyNamed('directory'),
      ),
    ).thenAnswer((_) async => true);

    // Simulate successful cleaning and size calculations
    when(
      mockCommandExecutor.runCleanCommand(
        directoryPath: anyNamed('directoryPath'),
        command: anyNamed('command'),
      ),
    ).thenAnswer((_) async => 0);
    when(
      mockDirectoryHelper.calculateDirectorySize(
        directory: anyNamed('directory'),
      ),
    ).thenAnswer((_) async => 100);

    var dirHelper = MockDirectoryHelper();

    when(
      dirHelper.getAllSubDirectories(
        directory: anyNamed('directory'),
      ),
    ).thenAnswer(
      (_) async => [
        MockDirectory(),
        MockDirectory(),
      ],
    );

    final flutterCleaner = FlutterCleaner(
      directory: directory,
      cleaningCommand: 'flutter clean',
      filesToCheck: [],
      directoryHelper: dirHelper,
      commandExecutor: mockCommandExecutor,
      projectValidator: mockProjectValidator,
    );

    final results = <CleaningResult>[];
    await for (var result in flutterCleaner.clean()) {
      results.add(result);
    }

    expect(results, hasLength(2));
    for (var result in results) {
      expect(result.success, true);
    }
  });
}
