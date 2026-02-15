import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final double scrHeight;
  final VoidCallback onTap;
  const ProfileListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.scrHeight,
    required this.onTap,
    // required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: scrHeight * 0.03,
      onTap: onTap,
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
