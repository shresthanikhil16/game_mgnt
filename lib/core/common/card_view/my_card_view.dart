import 'package:flutter/material.dart';

class MyCardView extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final bool isGradient;
  final Widget? page; // Make page nullable

  const MyCardView({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    this.isGradient = false,
    this.page, // No longer required
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          // Navigate only if page is not null
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page!),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circle with solid color or gradient background
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isGradient
                    ? const LinearGradient(
                        colors: [Colors.redAccent, Colors.deepOrange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isGradient ? null : color,
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 8),
            // Label
            Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
