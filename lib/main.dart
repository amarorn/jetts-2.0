import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_system/tokens/theme_extensions.dart';
import 'presentation/pages/onboarding/onboarding_screen.dart';
import 'presentation/pages/auth/login_screen.dart';
import 'presentation/pages/auth/register_screen.dart';
import 'presentation/pages/home/home_screen.dart';
import 'presentation/pages/owner/owner_home_screen.dart';
import 'presentation/pages/search/search_screen.dart';
import 'presentation/pages/favorites/favorites_screen.dart';
import 'presentation/pages/profile/profile_screen.dart';
// import 'services/notification_service.dart'; // Removido temporariamente
// import 'presentation/pages/notifications/notification_test_screen.dart'; // Removido temporariamente

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().initialize(); // Removido temporariamente
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jets App',
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/owner-home': (context) => const OwnerHomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/profile': (context) => const ProfileScreen(),
        // '/notifications': (context) => const NotificationTestScreen(), // Removido temporariamente
      },
    );
  }
}
