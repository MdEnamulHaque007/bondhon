import 'package:bondhon/features/feed/presentation/screens/feed_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeedScreen(showAppBar: false);
  }
}
