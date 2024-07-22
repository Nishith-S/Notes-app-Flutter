import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
 final Widget? title;
 final Widget? leading;
 final void Function()? onTap;
 const DrawerTile({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: ListTile(
        title: title,
        leading: leading,
        onTap: onTap,
      ),
    );
  }
}
