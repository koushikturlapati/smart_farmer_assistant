import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smart_farmer_assistant/app.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartFarmerApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}