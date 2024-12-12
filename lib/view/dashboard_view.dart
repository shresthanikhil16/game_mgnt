import 'package:flutter/material.dart';
import 'package:game_mgnt/common/my_card_view.dart'; // Import the MyCardView widget

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;
  bool _isDarkMode = false; // Track the theme state

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Method to toggle dark mode
  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    // Apply the theme change to the app
    if (_isDarkMode) {
      // Set dark theme
      Theme.of(context).copyWith(brightness: Brightness.dark);
    } else {
      // Set light theme
      Theme.of(context).copyWith(brightness: Brightness.light);
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of cute colors for the cards
    final List<Color> cardColors = [
      Colors.pink[100]!, // Soft pink
      Colors.lightBlue[100]!, // Soft blue
      Colors.lime[100]!, // Soft lime green
      Colors.amber[100]!, // Soft yellow
    ];

    // List of labels for the cards
    final List<String> cardLabels = [
      "Games",
      "Your Games",
      "History",
      "About Us",
    ];

    // Get screen size and orientation
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width; // Portrait or landscape

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo2.png', // Replace with the correct path to your logo
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              "GuidEngine",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          // Dark mode toggle button
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.dark_mode : Icons.light_mode, // Change icon based on theme state
            ),
            onPressed: _toggleDarkMode, // Toggle theme
          ),
        ],
      ),
      body: Column(
        children: [
          // Divider between AppBar and content
          const Divider(
            color: Colors.black38,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          // Add a greeting text below the AppBar, aligned to the left
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Added horizontal padding
            child: Align(
              alignment: Alignment.centerLeft, // Align the text to the left
              child: Text(
                "Hi! Pratham", // Greeting message
                style: TextStyle(
                  fontSize: 32, // Increased font size
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway', // Use Raleway font
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // Background Image with reduced opacity
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.2, // Adjust transparency here
                    child: Image.asset(
                      'assets/images/logo2.png', // Replace with the correct path to your logo
                      fit: BoxFit.cover, // Makes the image cover the screen
                    ),
                  ),
                ),
                // Main content: Grid of cards
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: isPortrait ? 2 : 3, // 2 columns in portrait, 3 in landscape
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(4, (index) {
                      return MyCardView(
                        label: cardLabels[index],
                        color: cardColors[index],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Navigation Bar (with adjustment)
          Transform.translate(
            offset: const Offset(0, -15), // Shift the BottomNavigationBar upwards by 10 units
            child: Container(
              width: isPortrait
                  ? MediaQuery.of(context).size.width * 0.7 // Decreased width for portrait mode
                  : MediaQuery.of(context).size.width * 0.5, // Decreased width for landscape mode
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),  // Rounded top-left corner
                  topRight: Radius.circular(30), // Rounded top-right corner
                  bottomLeft: Radius.circular(30), // Rounded bottom-left corner
                  bottomRight: Radius.circular(30), // Rounded bottom-right corner
                ),
                border: Border.all(
                  color: Colors.black, // Add a grey border around the bottom navigation bar
                  width: 2, // Set border width
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent, // Make BottomNavigationBar background transparent
                elevation: 0, // Remove the default shadow
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: "Chat",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
