import 'package:flutter/material.dart';
import 'package:notes/components/drawer_tile.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      child: Column(
        children: [
          //header
          const DrawerHeader(
            child: Icon(Icons.edit_document, size: 35,),
          ),
          //tiles
          DrawerTile(
            title: const Text("H o m e"),
            leading: const Icon(Icons.home),
            onTap: () => Navigator.of(context).pop(),
          ),
          DrawerTile(
            title: const Text("S e t t i n g s"),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
          ),
        ],
      ),
    );
  }
}
