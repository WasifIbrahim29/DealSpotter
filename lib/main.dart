import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/landing_screen.dart';
import 'screens/welcome_screen.dart';
import 'constants.dart';

void main() {
  runApp(DealSpotter());
}

class DealSpotter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: mainNavigatorKey,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
    );
  }
}
