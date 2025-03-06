import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_mgnt/features/contact_us/view/contact_us_view.dart'; // Import your ContactScreen

void main() {
  group('ContactScreen', () {
    testWidgets('displays contact details and send email button',
        (WidgetTester tester) async {
      // Build the ContactScreen widget
      await tester.pumpWidget(
        MaterialApp(
          home: const ContactScreen(),
        ),
      );

      // Check if the title is displayed
      expect(find.text('We\'d love to hear from you!'), findsOneWidget);

      // Check if the "Send Email" button is displayed
      expect(find.text('Send Email'), findsOneWidget);

      // Check if the email, phone, and address info are displayed
      expect(find.text('guidengine@gmail.com'), findsOneWidget);
      expect(find.text('+987 654 3210'), findsOneWidget);
      expect(find.text('123 Game Street, New York, NY'), findsOneWidget);
    });

    testWidgets('tapping on "Send Email" button does not throw error',
        (WidgetTester tester) async {
      // Build the ContactScreen widget
      await tester.pumpWidget(
        MaterialApp(
          home: const ContactScreen(),
        ),
      );

      // Find the "Send Email" button
      final sendEmailButton = find.text('Send Email');

      // Tap on the "Send Email" button
      await tester.tap(sendEmailButton);
      await tester.pump(); // Rebuild the widget after the tap

      // Since we're not testing the email sending, just ensure no errors are thrown
      // No specific behavior to verify here since the actual email launch is omitted
    });
  });
}
