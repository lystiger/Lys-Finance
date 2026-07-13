import 'package:flutter/material.dart';

class AppErrorScreen extends StatelessWidget {
  const AppErrorScreen({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final Widget content = Semantics(
      liveRegion: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.error_outline_rounded, size: 40),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Your data is safe. Close and reopen the app to try again.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    if (compact) {
      return Material(child: Center(child: content));
    }
    return Scaffold(
      body: SafeArea(child: Center(child: content)),
    );
  }
}
