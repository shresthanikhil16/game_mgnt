import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color(0xFF990000),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Who We Are'),
            const Text(
              'GameMNGT is a cutting-edge tournament management platform designed to streamline '
              'event organization, player registration, and match coordination. Our mission is to enhance '
              'the gaming experience by providing a seamless and intuitive platform for players and organizers alike.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Our Vision'),
            const Text(
              'We aim to revolutionize the esports and gaming industry by offering a robust solution '
              'that eliminates complexity in tournament management. Our platform is built to support fair play, '
              'real-time updates, and a smooth user experience.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Meet Our Team'),
            const Text(
              'Our team consists of passionate developers, designers, and gaming enthusiasts dedicated '
              'to building a platform that caters to the needs of players, organizers, and esports communities worldwide.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Get in Touch'),
            const Text(
              'Have questions or suggestions? We’d love to hear from you! Reach out to our support team for assistance.',
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to contact page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF990000),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Contact Us',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF990000),
            ),
      ),
    );
  }
}
