import 'package:flutter_gherkin/flutter_gherkin.dart'; // notice new import name
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';

import 'package:flutter_application/main.dart' as app;
import 'steps/example.dart';

part 'gherkin_suite_test.g.dart';

@GherkinTestSuite(useAbsolutePaths: false)
void main() {
  executeTestSuite(
    appMainFunction: appInitializationFn,
    configuration: gherkinTestConfiguration,
    scenarioExecutionTimeout: Timeout(Duration(minutes: 1, seconds: 30)), // remove this later maybe
  );
}

FlutterTestConfiguration gherkinTestConfiguration = FlutterTestConfiguration(
  stepDefinitions: [ // Automate step gathering somehow?
    whenloaded, opened,
  ],
  hooks: [ AttachScreenshotOnFailedStepHook() ],
  reporters: [
    StdoutReporter(MessageLevel.error)
      ..setWriteLineFn(print)
      ..setWriteFn(print),
    ProgressReporter()
      ..setWriteLineFn(print)
      ..setWriteFn(print),
    TestRunSummaryReporter()
      ..setWriteLineFn(print)
      ..setWriteFn(print),
    JsonReporter(
      writeReport: (_, __) => Future<void>.value(),
    ),
  ],
);

StartAppFn appInitializationFn = (World world) async {
  app.main();
};