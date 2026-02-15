import 'package:flutter/material.dart';

class CustomNavbarItem extends StatelessWidget {
  final IconData icon;
  final Color activeColor;
  final Color inactiveColor;
  final bool isActive;
  final VoidCallback onPressed;
  const CustomNavbarItem({
    super.key,
    required this.icon,
    required this.activeColor,
    required this.inactiveColor,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: Icon(
          icon,
          color: isActive ? activeColor : inactiveColor,
          key: ValueKey<bool>(isActive), // Unique key for each state
        ),
      ),
    );
  }
}
