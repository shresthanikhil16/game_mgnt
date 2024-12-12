import 'package:flutter/material.dart';
import 'package:game_mgnt/view/dashboard_view.dart';
import 'signup_view.dart';  // Make sure to import your SignupView

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

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

                  // Email TextField
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(fontFamily: 'Raleway'),
                      // Darker border color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password TextField
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(fontFamily: 'Raleway'),
                      // Darker border color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Remember Me and Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: false,
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
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to DashboardView when the button is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DashboardView()),
                        );
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
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Divider and Sign In options
                  Column(
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
                              'assets/icons/google.png',
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
                              'assets/icons/facebook.webp',
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
                  const SizedBox(height: 20),

                  // Sign Up option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Raleway'),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to SignupView when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpView()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            decoration: TextDecoration.underline,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45), // Add space to bottom
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
