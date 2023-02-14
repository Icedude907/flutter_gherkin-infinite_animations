// Contains the primary steps to get to different screens for testing.

import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_test/flutter_test.dart';

//---------------------
// Simple building blocks
//-------------------------

final whenloaded = when<FlutterWidgetTesterWorld>(
  'App is loaded and settled',
  (context) async {
    WidgetTester tester = context.world.rawAppDriver;
    await tester.pump();
  },
);

final opened = then<FlutterWidgetTesterWorld>(
  'I am on the right page',
  (context) async {
    WidgetTester tester = context.world.rawAppDriver;
    await tester.pump();
  },
);
