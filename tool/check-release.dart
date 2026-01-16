import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption(
      'version',
      abbr: 'v',
      help: 'Release version, e.g. 0.3.4 or 0.3.4+1',
    );

  late ArgResults results;
  try {
    results = parser.parse(arguments);
  } on FormatException catch (error) {
    _fail('Argument error: ${error.message}\n${parser.usage}');
  }

  final versionString = (results['version'] as String?)?.trim();
  if (versionString == null || versionString.isEmpty) {
    _fail('Missing required --version argument.\n${parser.usage}');
  }

  final version = _parseVersion(versionString);
  final expectedConstraint = '^$versionString';

  final maplibrePubspec = _loadYamlFile(File('maplibre/pubspec.yaml'));
  _ensure(
    maplibrePubspec['version'] == versionString,
    'maplibre/pubspec.yaml version must be $versionString',
  );
  final maplibreDependencies =
      (maplibrePubspec['dependencies'] as YamlMap?) ?? <Object?, Object?>{};
  _ensure(
    maplibreDependencies['maplibre_ios'] == expectedConstraint,
    'maplibre -> maplibre_ios constraint must be $expectedConstraint',
  );

  final maplibreIosPubspec = _loadYamlFile(File('maplibre_ios/pubspec.yaml'));
  _ensure(
    maplibreIosPubspec['version'] == versionString,
    'maplibre_ios/pubspec.yaml version must be $versionString',
  );

  final examplePubspec = _loadYamlFile(File('example/pubspec.yaml'));
  final exampleDependencies =
      (examplePubspec['dependencies'] as YamlMap?) ?? <Object?, Object?>{};
  _ensure(
    exampleDependencies['maplibre'] == expectedConstraint,
    'example/pubspec.yaml maplibre constraint must be $expectedConstraint',
  );

  _ensureChangelogEntry(File('maplibre/CHANGELOG.md'), versionString);
  _ensureChangelogEntry(File('maplibre_ios/CHANGELOG.md'), versionString);
  _ensureDocumentationVersion(File('website/versions.json'), version);

  final releaseNotes = _buildReleaseNotes(
    File('maplibre/CHANGELOG.md'),
    version,
  );
  final notesPath = 'build/release_notes.txt';
  _writeReleaseNotes(notesPath, releaseNotes);
  _writeGithubOutput('release_notes_path', notesPath);
  _writeGithubMultilineOutput('release_body', releaseNotes);
}

Version _parseVersion(String value) {
  try {
    return Version.parse(value.trim());
  } on FormatException catch (error) {
    _fail('Invalid version format: ${error.message}');
  }
}

YamlMap _loadYamlFile(File file) {
  if (!file.existsSync()) {
    _fail('Missing file: ${file.path}');
  }
  final content = file.readAsStringSync();
  final data = loadYaml(content);
  if (data is! YamlMap) {
    _fail('Unexpected YAML structure in ${file.path}');
  }
  return data;
}

void _ensure(bool condition, String message) {
  if (!condition) {
    _fail(message);
  }
}

void _ensureChangelogEntry(File changelog, String version) {
  final content = changelog.readAsStringSync();
  final headerPattern = RegExp(
    '^##\\s+${RegExp.escape(version)}\\b',
    multiLine: true,
  );
  if (!headerPattern.hasMatch(content)) {
    _fail('Missing changelog entry for $version in ${changelog.path}');
  }
}

void _ensureDocumentationVersion(File versionsFile, Version version) {
  if (!versionsFile.existsSync()) {
    _fail('Missing file: ${versionsFile.path}');
  }
  final entries = jsonDecode(versionsFile.readAsStringSync());
  if (entries is! List) {
    _fail('Unexpected versions.json format');
  }
  final majorMinorX = '${version.major}.${version.minor}.x';
  if (!entries.contains(majorMinorX)) {
    _fail('${versionsFile.path} missing entry $majorMinorX');
  }
}

String _buildReleaseNotes(File changelog, Version version) {
  final content = changelog.readAsStringSync();
  final headerPattern = RegExp(
    '^##\\s+${RegExp.escape(version.toString())}\\b.*',
    multiLine: true,
  );
  final match = headerPattern.firstMatch(content);
  if (match == null) {
    _fail('Missing changelog section for version ${version.toString()}');
  }
  final startIndex = match.end;
  final remaining = content.substring(startIndex);
  final nextHeaderIndex = remaining.indexOf(RegExp('^##\\s+', multiLine: true));
  final section = nextHeaderIndex == -1
      ? remaining
      : remaining.substring(0, nextHeaderIndex);
  final trimmed = section.trim();
  final buffer = StringBuffer(trimmed);
  if (trimmed.isNotEmpty) {
    buffer.write('\n');
  }
  buffer.writeln('Contributors: @josxha');
  return buffer.toString();
}

void _writeGithubMultilineOutput(String key, String value) {
  final outputPath = Platform.environment['GITHUB_OUTPUT'];
  if (outputPath == null || outputPath.isEmpty) {
    return;
  }
  final buffer = StringBuffer()
    ..writeln('$key<<EOF')
    ..writeln(value)
    ..writeln('EOF');
  File(outputPath).writeAsStringSync(buffer.toString(), mode: FileMode.append);
}

void _writeGithubOutput(String key, String value) {
  final outputPath = Platform.environment['GITHUB_OUTPUT'];
  if (outputPath == null || outputPath.isEmpty) {
    return;
  }
  File(outputPath).writeAsStringSync('$key=$value\n', mode: FileMode.append);
}

void _writeReleaseNotes(String path, String content) {
  final file = File(path);
  file.createSync(recursive: true);
  file.writeAsStringSync(content);
}

Never _fail(String message) {
  stderr.writeln(message);
  exit(1);
}
