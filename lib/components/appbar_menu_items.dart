import 'package:flutter/material.dart';

class AppBarMenu extends StatelessWidget {
 final Widget? child;
 final void Function()? onTap;
  const AppBarMenu({
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
