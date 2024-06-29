import 'package:flutter/material.dart';

class AppBarMenu extends StatelessWidget {
  Widget? child;
  void Function()? onTap;
  AppBarMenu({
    super.key,
    required this.child,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: child,
      ),
    );
  }
}
