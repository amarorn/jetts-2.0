import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_system/tokens/theme_extensions.dart';
import 'presentation/pages/onboarding/onboarding_screen.dart';
import 'presentation/pages/auth/login_screen.dart';
import 'presentation/pages/auth/register_screen.dart';
import 'presentation/pages/home/home_screen.dart';
import 'presentation/pages/search/search_screen.dart';
import 'presentation/pages/favorites/favorites_screen.dart';
import 'presentation/pages/profile/profile_screen.dart';
import 'services/notification_service.dart';
import 'presentation/pages/notifications/notification_test_screen.dart';
import 'presentation/pages/conductor/conductor_details_screen.dart';
import 'presentation/pages/booking_history/booking_history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jets App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/notifications': (context) => const NotificationTestScreen(),
        '/conductor_profile': (context) => ConductorDetailsScreen(),
        '/booking_history': (context) => BookingHistoryScreen(),
      },
    );
  }
} 