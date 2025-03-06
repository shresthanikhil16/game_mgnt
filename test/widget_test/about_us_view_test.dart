import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_mgnt/features/about_us/view/about_us_view.dart';

void main() {
  testWidgets('AboutUsScreen displays content correctly', (tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutUsScreen(),
      ),
    );

    // Act & Assert
    // Check the AppBar title
    expect(find.text('About Us'), findsOneWidget);

    // Check the 'Who We Are' section and text
    expect(find.text('Who We Are'), findsOneWidget);
    expect(
        find.text(
          'GameMNGT is a cutting-edge tournament management platform designed to streamline event organization, player registration, and match coordination. Our mission is to enhance the gaming experience by providing a seamless and intuitive platform for players and organizers alike.',
        ),
        findsOneWidget);

    // Check the 'Our Vision' section and text
    expect(find.text('Our Vision'), findsOneWidget);
    expect(
        find.text(
          'We aim to revolutionize the esports and gaming industry by offering a robust solution that eliminates complexity in tournament management. Our platform is built to support fair play, real-time updates, and a smooth user experience.',
        ),
        findsOneWidget);

    // Check the 'Meet Our Team' section and text
    expect(find.text('Meet Our Team'), findsOneWidget);
    expect(
        find.text(
          'Our team consists of passionate developers, designers, and gaming enthusiasts dedicated to building a platform that caters to the needs of players, organizers, and esports communities worldwide.',
        ),
        findsOneWidget);

    // Check the 'Get in Touch' section and text
    expect(find.text('Get in Touch'), findsOneWidget);
    expect(
        find.text(
          'Have questions or suggestions? We’d love to hear from you! Reach out to our support team for assistance.',
        ),
        findsOneWidget);

    // Check if the 'Contact Us' button exists
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify that tapping the 'Contact Us' button does not throw an error
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Simulate the tap and rebuild the widget tree
  });
}
