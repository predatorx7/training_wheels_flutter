import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaagaz/l10n/l10n.dart';

class _Navigation {
  final route = GoRoute(
    name: '/',
    path: '/',
    builder: (context, state) {
      return const HomeScreen();
    },
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final navigation = _Navigation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.home),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
