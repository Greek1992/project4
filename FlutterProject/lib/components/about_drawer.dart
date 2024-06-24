import 'package:flutter/material.dart';

class AboutDrawer extends StatelessWidget {
  const AboutDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _aboutDialog(context: context),
        ],
      ),
    );
  }

  Widget _aboutDialog({required BuildContext context}) {
    return ListTile(
      leading: Icon(
        Icons.info_outline_rounded,
        color: Colors.red,
      ),
      title: Text('over...'),
      onTap: () {
        Navigator.pop(context);
        showAboutDialog(
          context: context,
          applicationIcon: Icon(Icons.person),
          applicationLegalese: '2024 \u00a8 Summa Move',
          applicationVersion: '1.00',
          applicationName: 'Summa Move'
        );
      },
    );
  }
}
