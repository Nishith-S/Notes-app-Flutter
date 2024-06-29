import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
          tooltip: "Back",
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(25)
        ),
        margin: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 25,
        ),
        height: 89,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Dark mode"),
            CupertinoSwitch(
                value:
                context.watch<ThemeProvider>().isDark,
                onChanged: (value) {
                  setState(() {
                    context.read<ThemeProvider>().toggleTheme();
                  });
                }),
          ],
        ),
      ),
    );
  }
}
