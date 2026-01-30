import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart';

class PackageInfo {
  PackageInfo({
    required this.name,
    required this.directory,
    required this.pubspec,
  });

  final String name;
  final Directory directory;
  final YamlMap pubspec;

  File get pubspecFile => File('${directory.path}/pubspec.yaml');
  File get changelogFile => File('${directory.path}/CHANGELOG.md');
}

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

  final packages = _collectPackages(Directory('packages'));
  final packageNames = packages.map((package) => package.name).toSet();

  for (final package in packages) {
    _ensure(
      package.pubspec['version'] == versionString,
      '${package.pubspecFile.path} version must be $versionString',
    );

    final dependencies = _readDependencyMap(package.pubspec, 'dependencies');
    for (final entry in dependencies.entries) {
      if (!packageNames.contains(entry.key)) {
        continue;
      }
      final constraint = entry.value;
      _ensure(
        constraint is String && constraint == expectedConstraint,
        '${package.name} -> ${entry.key} constraint must be $expectedConstraint',
      );
    }

    _ensureChangelogEntry(package.changelogFile, versionString);
  }

  final examplePubspec = File('examples/pubspec.yaml');
  if (examplePubspec.existsSync()) {
    final exampleYaml = _loadYamlFile(examplePubspec);
    final exampleDependencies = _readDependencyMap(exampleYaml, 'dependencies');
    if (exampleDependencies.containsKey('maplibre')) {
      _ensure(
        exampleDependencies['maplibre'] == expectedConstraint,
        '${examplePubspec.path} maplibre constraint must be $expectedConstraint',
      );
    }
  }

  _ensureDocumentationVersion(File('website/versions.json'), version);

  final releaseNotesPackage = _selectReleaseNotesPackage(packages);
  final releaseNotes = _buildReleaseNotes(
    releaseNotesPackage.changelogFile,
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
  if (!changelog.existsSync()) {
    _fail('Missing file: ${changelog.path}');
  }
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

List<PackageInfo> _collectPackages(Directory root) {
  if (!root.existsSync()) {
    _fail('Missing packages directory: ${root.path}');
  }
  final directories = root.listSync().whereType<Directory>().toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  final packages = <PackageInfo>[];
  for (final directory in directories) {
    final pubspecFile = File('${directory.path}/pubspec.yaml');
    if (!pubspecFile.existsSync()) {
      continue;
    }
    final pubspec = _loadYamlFile(pubspecFile);
    final name = pubspec['name'];
    if (name is! String || name.trim().isEmpty) {
      _fail('Missing package name in ${pubspecFile.path}');
    }
    packages.add(
      PackageInfo(name: name.trim(), directory: directory, pubspec: pubspec),
    );
  }

  if (packages.isEmpty) {
    _fail('No packages found under ${root.path}');
  }

  return packages;
}

Map<String, Object?> _readDependencyMap(YamlMap pubspec, String key) {
  final value = pubspec[key];
  if (value is! YamlMap) {
    return <String, Object?>{};
  }
  return Map<String, Object?>.fromEntries(
    value.entries.map((entry) => MapEntry(entry.key.toString(), entry.value)),
  );
}

PackageInfo _selectReleaseNotesPackage(List<PackageInfo> packages) {
  for (final package in packages) {
    if (package.name == 'maplibre') {
      return package;
    }
  }
  return packages.first;
}

Never _fail(String message) {
  stderr.writeln(message);
  exit(1);
}
