import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_mgnt/features/dashboard/presentation/view_model/dashboard_cubit.dart';

class MyCardView extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Widget? page;
  final bool isGradient;
  final String? navigationTarget;
  final VoidCallback? onTap; // Optional onTap callback

  const MyCardView({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.page,
    this.isGradient = false,
    this.navigationTarget,
    this.onTap, // Optional onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(); // Use the provided onTap callback
        } else if (navigationTarget == 'Games') {
          // Trigger navigation using the Cubit method for "Games"
          context.read<DashboardCubit>().navigateToTournamentCreation(context);
        } else if (page != null) {
          // If there's a specific page, navigate to it
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
