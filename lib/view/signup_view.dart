import 'package:flutter/material.dart';
import 'login_view.dart';  // Import LoginView

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    double imageHeight = screenHeight * 0.3;
    if (screenWidth > screenHeight) {
      imageHeight = screenHeight * 0.2; // Adjust image size for landscape
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight, // Ensure content takes up full screen height
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container for the logo image
                  SizedBox(
                    height: imageHeight,
                    width: double.infinity,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          'assets/images/logo.png', // Replace with your logo image path
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sign Up title
                  const Text(
                    'Get Started!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: const TextStyle(fontFamily: 'Raleway'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(fontFamily: 'Raleway'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(fontFamily: 'Raleway'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sign Up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle sign-up button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF990000),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
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

                  // Divider and Sign Up options
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
                          'Or Sign Up With',
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
                                side: const BorderSide(color: Colors.grey),
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
                  const SizedBox(height: 20),

                  // Already have an account? Sign In option
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Raleway'),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to LoginView when tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginView()),
                            );
                          },
                          child: const Text(
                            'Sign In',
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
          ),
        ),
      ),
    );
  }
}
