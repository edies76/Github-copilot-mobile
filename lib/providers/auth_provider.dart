import 'package:flutter/material.dart';
import '../models/github_user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  GitHubUser? _currentUser;
  bool _isLoading = false;
  String? _error;
  bool _isAuthenticated = false;

  GitHubUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      _isAuthenticated = await _authService.isAuthenticated();
      if (_isAuthenticated) {
        _currentUser = await _authService.getCurrentUser();
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String token) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _authService.authenticateWithGitHub(token);
      if (success) {
        _isAuthenticated = true;
        _currentUser = await _authService.getCurrentUser();
        return true;
      } else {
        _error = 'Failed to authenticate with GitHub';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
      _currentUser = null;
      _isAuthenticated = false;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProfile(String username) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = await _authService.fetchUserProfile(username);
      if (user != null) {
        _currentUser = user;
      } else {
        _error = 'User not found';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
