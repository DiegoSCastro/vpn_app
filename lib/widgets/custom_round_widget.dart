import 'package:flutter/material.dart';

class CustomRoundWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget roundWidget;
  const CustomRoundWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.roundWidget,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.46,
      child: Column(
        children: [
          roundWidget,
          const SizedBox(height: 7),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
