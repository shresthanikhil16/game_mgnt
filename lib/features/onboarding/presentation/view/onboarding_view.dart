import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/auth/presentation/view/login_view.dart';
import 'package:game_mgnt/features/auth/presentation/view/register_view.dart';
import 'package:game_mgnt/features/auth/presentation/view_model/login/login_bloc.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
            // CTA Section
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterView(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color(0xFF990000),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Get Started'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: BlocProvider.of<LoginBloc>(context),
                                child: const LoginView(),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Color(0xFF990000)),
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
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 150),
          Text(title, style: TextStyle(fontSize: 28, color: Colors.white)),
          Text(subtitle, style: TextStyle(fontSize: 18, color: Colors.white70)),
        ],
      ),
    );
  }
}
