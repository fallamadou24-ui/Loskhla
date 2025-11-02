import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/artisan_list_screen.dart';
import 'screens/artisan_detail_screen.dart';
import 'screens/messaging_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const ArtisansConnectApp());
}

class ArtisansConnectApp extends StatelessWidget {
  const ArtisansConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artisans Connect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        ArtisanListScreen.routeName: (_) => const ArtisanListScreen(),
        ArtisanDetailScreen.routeName: (_) => const ArtisanDetailScreen(),
        MessagingScreen.routeName: (_) => const MessagingScreen(),
        ProfileScreen.routeName: (_) => const ProfileScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
