import 'dart:convert';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:path/path.dart' as path;
import 'package:integration_test/integration_test_driver.dart' as integration_test_driver;

Future<void> main() {
  integration_test_driver.testOutputsDirectory = 'integration_test/gherkin/reports';
  // FlutterDriver().runUnsynchronized(() => null);
  return integration_test_driver.integrationDriver(
    responseDataCallback: writeGherkinReports
  );
}

Future<void> writeGherkinReports(Map<String, dynamic>? data) async {
  await integration_test_driver.writeResponseData(
    data,
    testOutputFilename: 'gherkin_reports',
  );

  final reports = json.decode(data!['gherkin_reports'].toString()) as List<dynamic>;
  final filenamePrefix = DateTime.now().toIso8601String().split('.').first.replaceAll(':', '-');

  for (var i = 0; i < reports.length; i += 1) {
    final reportData = reports.elementAt(i) as List<dynamic>;

    await fs.directory(integration_test_driver.testOutputsDirectory).create(recursive: true);
    final File file = fs.file(path.join(
      integration_test_driver.testOutputsDirectory,
      '$filenamePrefix-$i.json',
    ));
    final String resultString = _encodeJson(reportData, true);
    await file.writeAsString(resultString);
  }
}

const JsonEncoder _prettyEncoder = JsonEncoder.withIndent('  ');
String _encodeJson(Object jsonObject, bool pretty) {
  return pretty ? _prettyEncoder.convert(jsonObject) : json.encode(jsonObject);
}
