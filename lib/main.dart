import 'package:flutter/material.dart';

void main() {
  runApp(const BondhonApp());
}

class BondhonApp extends StatelessWidget {
  const BondhonApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF006A4E);
    return MaterialApp(
      title: 'Bondhon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 112,
                    height: 112,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.forum_rounded,
                      size: 58,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Bondhon',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: colors.primary,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'কথায় কথায় গড়ে উঠুক বন্ধন',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.login_rounded),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('শুরু করুন'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Bangladesh-made social chat and community platform',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
