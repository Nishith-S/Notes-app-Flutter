import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuItems extends StatelessWidget {
  final void Function()? onDeleteTap;
  const MenuItems({
    super.key,
   required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: onDeleteTap,
          child: const SizedBox(
            height: 40,
            width: 100,
            child: Center(child: Text("Delete")),
          ),
        ),
      ],
    );
  }
}
