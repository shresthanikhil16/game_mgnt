import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/network/hive_service.dart';
import '../../data/model/auth_hive_model.dart';
import 'login_view.dart'; // Import the model

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Image.asset(
                        'assets/images/logo2.png',
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'GuidEngine',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF990000),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Create a New Account',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Fill in the details below to get started',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildTextField(
                        context,
                        controller: usernameController,
                        label: 'Username',
                        focusNode: usernameFocusNode,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        context,
                        controller: emailController,
                        label: 'Email',
                        focusNode: emailFocusNode,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        context,
                        controller: passwordController,
                        label: 'Password',
                        obscureText: true,
                        focusNode: passwordFocusNode,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        context,
                        controller: confirmPasswordController,
                        label: 'Re-enter Password',
                        obscureText: true,
                        focusNode: confirmPasswordFocusNode,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            final username = usernameController.text.trim();
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            final confirmPassword =
                                confirmPasswordController.text.trim();

                            if (password == confirmPassword) {
                              // Create AuthHiveModel instance
                              final authModel = AuthHiveModel(
                                studentId:
                                    email, // Assuming the email is unique and used as ID
                                username: username,
                                email: email,
                                password: password, confirmPassword: '',
                              );

                              try {
                                final hiveService =
                                    HiveService(); // Create an instance of HiveService
                                await hiveService.register(
                                    authModel); // Call instance method

                                // Show success snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Registration Successful'),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                // Navigate to the login screen or home
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginView(),
                                  ),
                                );
                              } catch (e) {
                                // Handle registration error
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Registration Failed: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              // Show password mismatch error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Passwords do not match'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } else {
                            // Show validation error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill in all fields'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF990000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 100),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                color: Color(0xFF990000),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context,
      {required TextEditingController controller,
      required String label,
      bool obscureText = false,
      required FocusNode focusNode}) {
    return SizedBox(
      height: 35,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label cannot be empty';
          }
          if (label == 'Email' && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.montserrat(
            color: Colors.black,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }
}
