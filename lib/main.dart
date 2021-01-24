import 'package:deal_spotter/providers/user_provider.dart';
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
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: MaterialApp(
        key: mainNavigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
        },
      ),
    );
  }
}
