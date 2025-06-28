import 'package:flutter/material.dart';
import 'owner_home_screen.dart';

class OwnerRoutes {
  static const String ownerHome = '/owner-home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      ownerHome: (context) => const OwnerHomeScreen(),
    };
  }
}
