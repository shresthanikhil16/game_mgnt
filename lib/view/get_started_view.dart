import 'package:flutter/material.dart';
import 'package:game_mgnt/view/login_view.dart';
import 'package:game_mgnt/view/signup_view.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'imagePath': 'assets/images/logo3.png',
      'title': 'Welcome!',
      'subtitle': 'Join the Community',
      'gradientColors': [Color(0xFF990000), Color(0xFF4B0000)],
    },
    {
      'imagePath': 'assets/images/logo3.png',
      'title': 'Explore Games',
      'subtitle': 'Find and manage your favorite games',
      'gradientColors': [Color(0xFF4B0000), Color(0xFF990000)],
    },
    {
      'imagePath': 'assets/images/logo3.png',
      'title': 'Stay Connected',
      'subtitle': 'Connect with players globally',
      'gradientColors': [Color(0xFF990000), Color(0xFF4B0000)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLandscape
            ? Row(
                children: [
                  // Left: Swipable Hero Section
                  Flexible(
                    flex: 3,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final page = _pages[index];
                        return SwipablePage(
                          imagePath: page['imagePath'],
                          title: page['title'],
                          subtitle: page['subtitle'],
                          gradientColors: page['gradientColors'],
                        );
                      },
                    ),
                  ),
                  // Right: CTA Section
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Dots Indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _pages.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: _currentPage == index ? 12 : 8,
                              height: _currentPage == index ? 12 : 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? const Color(0xFF990000)
                                    : Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Get Started Button
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isLandscape
                                ? screenWidth * 0.1
                                : screenWidth * 0.2,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpView()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                              backgroundColor: const Color(0xFF990000),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Footer Section: Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginView()),
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF990000),
                                  fontFamily: 'Raleway',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  // Hero Section
                  Flexible(
                    flex: 4,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final page = _pages[index];
                        return SwipablePage(
                          imagePath: page['imagePath'],
                          title: page['title'],
                          subtitle: page['subtitle'],
                          gradientColors: page['gradientColors'],
                        );
                      },
                    ),
                  ),
                  // Dots Indicator
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: _currentPage == index ? 12 : 8,
                          height: _currentPage == index ? 12 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? const Color(0xFF990000)
                                : Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // CTA Section
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.2,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpView()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                              backgroundColor: const Color(0xFF990000),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Footer Section: Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginView()),
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF990000),
                                  fontFamily: 'Raleway',
                                ),
                              ),
                            ),
                          ],
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

/// Swipable Page Widget
class SwipablePage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;

  const SwipablePage({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: MediaQuery.of(context).size.height * 0.25,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Raleway',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
              fontFamily: 'Raleway',
            ),
          ),
        ],
      ),
    );
  }
}
