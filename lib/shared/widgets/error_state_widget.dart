import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  const ErrorStateWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_rounded, size: 96, color: onSurfaceColor),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center)
          ],
        ),
      )
    );
  }
}