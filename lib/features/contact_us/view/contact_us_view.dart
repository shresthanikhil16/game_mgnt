import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'guidengine@gmail.com',
      query: 'subject=Support Request&body=Hello, I need help with...',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint('Could not launch email client.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF990000),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We\'d love to hear from you!',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you have any questions, suggestions, or need support, feel free to reach out to us through the details below.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ListTile(
                      leading: Icon(Icons.email, color: Color(0xFF990000)),
                      title: Text('Email'),
                      subtitle: Text('guidengine@gmail.com'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: Color(0xFF990000)),
                      title: Text('Phone'),
                      subtitle: Text('+987 654 3210'),
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.location_on, color: Color(0xFF990000)),
                      title: Text('Address'),
                      subtitle: Text('123 Game Street, New York, NY'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _sendEmail,
                icon: const Icon(CupertinoIcons.mail),
                label: const Text('Send Email'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF990000),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
