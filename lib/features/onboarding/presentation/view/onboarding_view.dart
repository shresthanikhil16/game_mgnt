import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../auth/presentation/view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OnboardingView());
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 41,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 12.5,
            color: Colors.white,
          ),
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: const [
              OnboardingPage(
                title: 'Join the Community',
                imagePath: 'assets/images/fortnite2.jpg',
                titleFontSize: 27,
              ),
              OnboardingPage(
                title: 'Find and manage your favorite games',
                imagePath: 'assets/images/mobilelegends.jpg',
                titleFontSize: 28,
              ),
              OnboardingPage(
                title: 'Connect with players globally',
                imagePath: 'assets/images/valorant1.jpeg',
                titleFontSize: 25.5,
                showGetStartedButton: true,
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height *
                0.04, // Adjusted bottom spacing
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6), // Smaller spacing
                  child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: CircleAvatar(
                      radius: 5, // Smaller size
                      backgroundColor: _currentPage == index
                          ? const Color(0xFF8B0000) // Dark red
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final double titleFontSize;
  final bool showGetStartedButton;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.titleFontSize,
    this.showGetStartedButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          height: screenHeight * 0.7,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.77, // Lower the text more
          left: 0,
          right: 0,
          child: Container(
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Color(0xFF4B0000),
                  Color(0xFF990000),
                ],
                stops: [
                  0.0,
                  0.7,
                  1.0,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 7.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 22), // Adjust the spacing
                  Text(
                    title,
                    style: textTheme.displayLarge!.copyWith(
                      fontSize: titleFontSize,
                    ),
                  ),
                  if (showGetStartedButton) ...[
                    const SizedBox(height: 25), // Reduced spacing
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Transform.translate(
                        offset: const Offset(-10, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white
                                .withOpacity(0.3), // Set to transparent white
                            fixedSize:
                                const Size(178, 50), // Reduced button height
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                          ),
                          child: Text(
                            'GET STARTED',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 18, // Reduced font size
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
