import 'package:flutter/material.dart';

import '../components/about_drawer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About'),),
      drawer: AboutDrawer(),
    );
  }
}
