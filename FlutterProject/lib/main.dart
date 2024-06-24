import 'package:flutter/material.dart';
import 'package:project4summamove/pages/inloggen_page.dart';
import 'package:project4summamove/pages/nonlog_move_page.dart';

import 'pages/achievement_page.dart';
import 'pages/about_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const SummaMoveApp());
}

class SummaMoveApp extends StatefulWidget {
  const SummaMoveApp({super.key});

  @override
  State<SummaMoveApp> createState() => _SummaMoveAppState();
}

class _SummaMoveAppState extends State<SummaMoveApp> {
  bool _geautenticeerd = false;

  void _autenticatieStatus(bool status){
    _geautenticeerd = status;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books app',
      home: _geautenticeerd
          ? HomePage(setAutenticatieStatus: _autenticatieStatus)
          : NonlogMovePage(setAutenticatieStatus: _autenticatieStatus),
    );

  }
}
