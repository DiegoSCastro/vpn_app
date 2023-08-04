import 'package:flutter/material.dart';

class NoVpnFoundWidget extends StatelessWidget {
  const NoVpnFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No VPN Found, Try Again.',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
