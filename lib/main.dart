import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/landing/landing_page.dart';

void main() {
  runApp(const NodoApp());
}

class NodoApp extends StatelessWidget {
  const NodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NODO — Servicios técnicos confiables',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LandingPage(),
    );
  }
}
