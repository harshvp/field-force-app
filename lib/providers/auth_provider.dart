// --- 2. THE STATE MANAGER (The Brain) ---
import 'package:flutter/cupertino.dart';

import '../models/models.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // Mock Login Function
  void login(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}