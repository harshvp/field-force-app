import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/auth_provider.dart';


//  Main Screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _attemptLogin() async {
    // 1. Run Form Validation
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // 2. Fake Network Delay to make it look nice
      await Future.delayed(const Duration(seconds: 1));

      final username = _usernameController.text.trim().toLowerCase();
      final password = _passwordController.text.trim();

      // 3. Check Demo Credentials
      if (password != 'demo123') {
        setState(() {
          _errorMessage = 'Invalid password. Hint: Use demo123';
          _isLoading = false;
        });
        return;
      }

      User? user;
      if (username == 'manager') {
        user = User(id: 'u1', name: 'Bob Manager', role: 'Manager');
      } else if (username == 'agent') {
        user = User(id: 'u2', name: 'Charlie Agent', role: 'Agent');
      } else {
        setState(() {
          _errorMessage = 'User not found. Try "manager" or "agent".';
          _isLoading = false;
        });
        return;
      }

      //  Log them in if Success
      if (mounted) {
        context.read<AuthProvider>().login(user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.security, size: 80, color: Colors.blueGrey),
                const SizedBox(height: 24),
                const Text(
                  'Field Force Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),

                // USERNAME FIELD
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter a username' : null,
                ),
                const SizedBox(height: 16),

                // PASSWORD FIELD
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword, //
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // This flips the true/false state and redraws the screen
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter a password' : null,
                ),
                const SizedBox(height: 16),

                // ERROR MESSAGE DISPLAY
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // SUBMIT BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _isLoading ? null : _attemptLogin,
                  child: _isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Login', style: TextStyle(fontSize: 18)),
                ),

                const SizedBox(height: 24),
                const Text(
                  'Demo Credentials:\nManager: manager / demo123\nAgent: agent / demo123',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}