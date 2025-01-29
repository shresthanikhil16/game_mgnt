import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/core/common/snackbar/my_snackbar.dart';
import 'package:game_mgnt/features/auth/presentation/view/register_view.dart';
import 'package:game_mgnt/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:game_mgnt/features/dashboard/presentation/view/dashboard_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/images/logo2.png',
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    // App Name
                    const Text(
                      'GuidEngine',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF990000),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Welcome Text
                    const Text(
                      'Welcome back!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Subtitle Text
                    const Text(
                      'Use Credentials to access your account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Form for Username and Password
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Username Field
                          TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0xFF990000),
                              ),
                              hintText: 'Enter Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFF990000)),
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black), // Set text color to black
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // Password Field
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color(0xFF990000),
                              ),
                              hintText: 'Enter Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFF990000)),
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black), // Set text color to black
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Handle forgot password
                              },
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(color: Color(0xFF990000)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Login Button
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      LoginStudentEvent(
                                        username: usernameController.text,
                                        password: passwordController.text,
                                        context: context,
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
                              'Log In',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Register Navigation
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don’t have an account? ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.read<LoginBloc>().add(
                                        NavigateRegisterScreenEvent(
                                          context: context,
                                          destination: RegisterView(),
                                        ),
                                      );
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Color(0xFF990000),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // BlocListener for LoginBloc
                          BlocListener<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state.isSuccess) {
                                showMySnackBar(
                                  context: context,
                                  message: "Login Successful",
                                  color: Colors.green,
                                );
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashboardView(),
                                    ),
                                  );
                                });
                              } else if (state.isLoading) {
                                showMySnackBar(
                                  context: context,
                                  message: "Logging in...",
                                  color: Colors.blueAccent,
                                );
                              }
                            },
                            child: Container(),
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
      ),
    );
  }
}
