import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_system/tokens/theme_extensions.dart';
import 'presentation/pages/onboarding/onboarding_screen.dart';
import 'presentation/pages/auth/login_screen.dart';
import 'presentation/pages/auth/register_screen.dart';
import 'presentation/pages/home/home_screen.dart';
import 'presentation/pages/owner/owner_home_screen.dart';
import 'presentation/pages/search/search_screen.dart';
import 'presentation/pages/search/map_search_screen.dart';
import 'presentation/pages/favorites/favorites_screen.dart';
import 'presentation/pages/profile/profile_screen.dart';
import 'presentation/pages/kyc/kyc_verification_screen.dart';
import 'presentation/pages/owner/owner_dashboard_screen.dart';
import 'presentation/pages/owner/dynamic_pricing_screen.dart';
import 'presentation/pages/reviews/detailed_review_screen.dart';
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
        '/map-search': (context) => const MapSearchScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/kyc-verification': (context) => const KYCVerificationScreen(),
        '/owner-dashboard': (context) => const OwnerDashboardScreen(),
        // '/notifications': (context) => const NotificationTestScreen(), // Removido temporariamente
      },
      onGenerateRoute: (settings) {
        // Rotas com parâmetros
        if (settings.name == '/dynamic-pricing') {
          final args = settings.arguments as Map<String, String>?;
          return MaterialPageRoute(
            builder: (context) => DynamicPricingScreen(
              boatId: args?['boatId'] ?? '',
              boatName: args?['boatName'] ?? '',
            ),
          );
        }
        
        if (settings.name == '/detailed-review') {
          final args = settings.arguments as Map<String, String>?;
          return MaterialPageRoute(
            builder: (context) => DetailedReviewScreen(
              boatId: args?['boatId'] ?? '',
              boatName: args?['boatName'] ?? '',
            ),
          );
        }
        
        return null;
      },
    );
  }
}
