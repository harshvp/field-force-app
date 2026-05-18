import 'package:field_force/providers/app_provider.dart';
import 'package:field_force/providers/auth_provider.dart';
import 'package:field_force/screens/agent_dashboard.dart';
import 'package:field_force/screens/login__screen.dart';
import 'package:field_force/screens/manager_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';


//  MAIN APP ROUTING
void main() {
  runApp(
    // wrap in provider so any screen can access AuthProvider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const FieldForceApp(),
    ),
  );
}

class FieldForceApp extends StatelessWidget {
  const FieldForceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Field Force App',
      theme: ThemeData(primarySwatch: Colors.blue),
      // The Consumer listens to AuthProvider. If user logs in/out, this redraws.
      home: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (!auth.isLoggedIn) {
            return const LoginScreen();
          }

          // Role-based UI Routing
          if (auth.currentUser!.role == 'Manager') {
            return const ManagerDashboard();
          } else {
            return const AgentDashboard();
          }
        },
      ),
    );
  }
}






