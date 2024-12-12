import 'package:flutter/material.dart';

class MyCardView extends StatelessWidget {
  final String label;
  final Color color;

  const MyCardView({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0), // Increased border radius for more roundness
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.0), // Same border radius for consistency
          border: Border.all(
            color: Colors.black, // Border color of the card
            width: 2, // Border width of the card
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0), // Padding around the text
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white, // Border color for the text
                width: 2, // Border width for the text
              ),
              borderRadius: BorderRadius.circular(10.0), // Round the corners of the text border
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
