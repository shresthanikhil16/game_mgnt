import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    // Adjust the image height to 30% of the screen height
    double imageHeight = screenHeight * 0.3; // 30% of the screen height

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container for the logo image
            SizedBox(
              height: imageHeight,
              width: double.infinity, // Full width of the screen
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black, // Set the background color to black
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ), // Optional rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/images/logo.png', // Replace with your logo image path
                    fit: BoxFit.contain, // Ensure the image scales proportionally
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Add spacing below the logo image

            // Login title
            const Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(height: 20),

            // Example text field for email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(fontFamily: 'Raleway'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Example text field for password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(fontFamily: 'Raleway'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Remember Me and Forgot Password Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: false, // Set to true if checked by default
                        onChanged: (bool? value) {
                          // Handle checkbox toggle
                        },
                      ),
                      const Text(
                        'Remember Me',
                        style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle "Forgot Password" action
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red, // Changed to red
                        decoration: TextDecoration.underline,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Login button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                width: double.infinity, // Make the button as wide as possible
                child: ElevatedButton(
                  onPressed: () {
                    // Handle login button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF990000), // Button color
                    foregroundColor: Colors.white, // Text color
                    padding: const EdgeInsets.symmetric(vertical: 15), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Divider and Sign In options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Or Sign In With',
                    style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Raleway'),
                  ),
                  const SizedBox(height: 10),

                  // Google and Facebook Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle Google sign-in
                        },
                        icon: Image.asset(
                          'assets/icons/google.png', // Replace with your Google icon image path
                          width: 20,
                          height: 20,
                        ),
                        label: const Text(
                          'Google',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.grey), // Border color
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle Facebook sign-in
                        },
                        icon: Image.asset(
                          'assets/icons/facebook.webp', // Replace with your Facebook icon image path
                          width: 20,
                          height: 20,
                        ),
                        label: const Text(
                          'Facebook',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Sign Up option
            Padding(
              padding: const EdgeInsets.only(bottom: 45.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Raleway'),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle sign-up navigation
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red, // Changed to red
                        decoration: TextDecoration.underline,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
