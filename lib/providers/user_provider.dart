import 'package:flutter/material.dart';
import 'package:local_data_app/models/user.dart';
import 'package:local_data_app/services/shared_prefs_service.dart';

/// A provider class that manages user-related state and operations.
class UserProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = true; // Initialize as true to show loader first
  bool _isInitialized = false; // Track if initial load is complete
  String? _error;

  /// Returns the current user, if any.
  User? get user => _user;

  /// Returns whether the provider is currently loading data.
  bool get isLoading => _isLoading;

  /// Returns whether the initial user data load is complete.
  bool get isInitialized => _isInitialized;

  /// Returns the current error message, if any.
  String? get error => _error;

  /// Sets the loading state and notifies listeners.
  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  /// Sets the error message and notifies listeners.
  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  /// Loads the user data from shared preferences.
  /// Throws an exception if the operation fails.
  Future<void> loadUser() async {
    if (_isInitialized) return; // Skip if already initialized

    try {
      _setLoading(true);
      _setError(null);

      _user = await SharedPrefsService.instance.getUser();
      _isInitialized = true;
    } catch (e) {
      _setError('Failed to load user: ${e.toString()}');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Saves a new user with the given name.
  /// Throws an exception if the operation fails.
  Future<void> saveUser(String name) async {
    try {
      _setLoading(true);
      _setError(null);

      _user = User(name: name);
      await SharedPrefsService.instance.saveUser(_user!);
      _isInitialized = true;
    } catch (e) {
      _setError('Failed to save user: ${e.toString()}');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Clears the current user data.
  /// Throws an exception if the operation fails.
  Future<void> clearUser() async {
    try {
      _setLoading(true);
      _setError(null);

      await SharedPrefsService.instance.clearUser();
      _user = null;
      _isInitialized = false;
    } catch (e) {
      _setError('Failed to clear user: ${e.toString()}');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }
}
