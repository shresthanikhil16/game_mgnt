import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/core/common/snackbar/my_snackbar.dart';
import 'package:game_mgnt/features/auth/presentation/view/login_view.dart';
import 'package:game_mgnt/features/auth/presentation/view_model/signup/register_bloc.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // Logo
                  Image.asset('assets/images/logo2.png', height: 100),
                  const SizedBox(height: 20),
                  // App Name
                  const Text(
                    'GuidEngine',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF990000)),
                  ),
                  const SizedBox(height: 20),
                  // Sign Up Text
                  const Text(
                    'Create a New Account',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  // Subtitle Text
                  const Text(
                    'Fill in the details below to get started',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  // Form
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Username Field
                        _buildTextField(context,
                            controller: usernameController, label: 'Username'),
                        const SizedBox(height: 20),
                        // Email Field
                        _buildTextField(context,
                            controller: emailController, label: 'Email'),
                        const SizedBox(height: 20),
                        // Password Field
                        _buildTextField(context,
                            controller: passwordController,
                            label: 'Password',
                            obscureText: true),
                        const SizedBox(height: 20),
                        // Confirm Password Field
                        _buildTextField(
                          context,
                          controller: confirmPasswordController,
                          label: 'Re-enter Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 30),
                        // Sign Up Button
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                context.read<RegisterBloc>().add(
                                      RegisterStudent(
                                        context: context,
                                        username: usernameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text,
                                      ),
                                    );
                              } else {
                                showMySnackBar(
                                  context: context,
                                  message: "Passwords do not match",
                                  color: Colors.red,
                                );
                              }
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
                          child: const Text('Sign Up',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                        const SizedBox(height: 20),
                        // Already have an account? Login
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
                                      builder: (context) => LoginView()),
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
                  // Listen to RegisterBloc state
                  BlocListener<RegisterBloc, RegisterState>(
                    listener: (context, state) {
                      if (state.isSuccess) {
                        showMySnackBar(
                          context: context,
                          message: "Registration Successful",
                          color: Colors.green,
                        );

                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                          );
                        });
                      } else if (state.isLoading) {
                        showMySnackBar(
                          context: context,
                          message: "Registering...",
                          color: Colors.blueAccent,
                        );
                      }
                    },
                    child: Container(),
                  ),
                ],
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
      bool obscureText = false}) {
    return TextFormField(
      controller: controller,
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
      style: const TextStyle(color: Colors.black), // Added text color black
      decoration: InputDecoration(
        prefixIcon: Icon(
          label == 'Username'
              ? Icons.person
              : label == 'Email'
                  ? Icons.email
                  : Icons.lock,
          color: const Color(0xFF990000),
        ),
        hintText: 'Enter $label',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF990000)),
        ),
      ),
    );
  }
}
