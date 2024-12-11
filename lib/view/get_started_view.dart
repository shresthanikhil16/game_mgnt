import 'package:flutter/material.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLandscape = screenWidth > screenHeight; // Check if the device is in landscape mode

    // Calculate the image height dynamically based on the screen height
    double imageHeight = screenHeight * 0.6; // 60% of the screen height for the image area
    double imageLogoHeight = screenHeight * 0.5; // 50% of the screen height for the logo image

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // Make the entire screen scrollable
          child: Column(
            children: [
              // Container for the image, size adjusted using MediaQuery
              SizedBox(
                height: imageHeight,
                width: double.infinity, // Set to full screen width
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black, // Set the background color to black
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ), // Optional rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      'assets/images/logo.png', // Replace with your image path
                      height: imageLogoHeight,
                      fit: BoxFit.contain, // Ensure the image scales proportionally
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Reduced space between the image and text

              // Row for the controller icon and both texts
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Controller icon to the left of both texts
                  Image.asset(
                    'assets/icons/controller2.png', // Icon image path
                    width: isLandscape ? screenWidth * 0.15 : screenWidth * 0.2, // Adjust icon size based on screen width
                    height: isLandscape ? screenWidth * 0.15 : screenWidth * 0.2, // Adjust icon size based on screen width
                  ),
                  const SizedBox(width: 20), // Add spacing between the icon and the texts

                  // Column containing both texts
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // "Welcome!" text
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 24, // Set the font size
                          fontFamily: 'Raleway', // Use the Raleway font
                          fontWeight: FontWeight.bold, // Set the font weight to bold
                        ),
                      ),
                      SizedBox(height: 10), // Add spacing between the texts
                      // "Join the Community" text
                      Text(
                        'Join the Community',
                        style: TextStyle(
                          fontSize: 18, // Set the font size
                          fontFamily: 'Raleway', // Use the Raleway font
                          fontWeight: FontWeight.w500, // Medium weight for secondary text
                          color: Colors.black, // Optional: Set text color to grey
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20), // Reduced space between text and button

              // The Get Started button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0), // Reduced vertical padding
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press here, such as navigating to another screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF990000), // Set button color to #990000 (red)
                    foregroundColor: Colors.white, // Set the text color inside the button to white
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners for button
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18, // Set font size of button text
                      fontWeight: FontWeight.bold, // Bold button text
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
