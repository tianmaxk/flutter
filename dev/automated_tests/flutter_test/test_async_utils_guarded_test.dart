// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class TestTestBinding extends AutomatedTestWidgetsFlutterBinding {
  @override
  DebugPrintCallback get debugPrintOverride => testPrint;
  static void testPrint(String message, { int wrapWidth }) { print(message); }
}

Future<Null> guardedHelper(WidgetTester tester) {
  return TestAsyncUtils.guard(() async {
    await tester.pumpWidget(const Text('Hello', textDirection: TextDirection.ltr));
  });
}

void main() {
  new TestTestBinding();
  testWidgets('TestAsyncUtils - custom guarded sections', (WidgetTester tester) async {
    await tester.pumpWidget(new Container());
    expect(find.byElementType(Container), isNotNull);
    guardedHelper(tester);
    expect(find.byElementType(Container), isNull);
    // this should fail
  });
}
