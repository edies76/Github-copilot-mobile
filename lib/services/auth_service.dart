import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import '../models/github_user.dart';

class AuthService {
  static const String _tokenKey = 'github_token';
  static const String _userKey = 'github_user';
  static const String _githubApiUrl = 'https://api.github.com';
  
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  // Simular autenticación con GitHub (en producción usarías OAuth)
  Future<bool> authenticateWithGitHub(String token) async {
    try {
      // Validar token obteniendo información del usuario
      final response = await _dio.get(
        '$_githubApiUrl/user',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final user = GitHubUser.fromJson(response.data);
        
        // Guardar token de forma segura
        await _secureStorage.write(key: _tokenKey, value: token);
        
        // Guardar información del usuario
        await _secureStorage.write(
          key: _userKey,
          value: _userToJson(user),
        );
        
        return true;
      }
      return false;
    } catch (e) {
      print('Error authenticating: $e');
      return false;
    }
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<GitHubUser?> getCurrentUser() async {
    try {
      final userJson = await _secureStorage.read(key: _userKey);
      if (userJson != null) {
        return _userFromJson(userJson);
      }
      return null;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _userKey);
  }

  Future<GitHubUser?> fetchUserProfile(String username) async {
    try {
      final token = await getToken();
      final response = await _dio.get(
        '$_githubApiUrl/users/$username',
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return GitHubUser.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  String _userToJson(GitHubUser user) {
    final json = user.toJson();
    return json.toString();
  }

  GitHubUser? _userFromJson(String jsonString) {
    try {
      // Parse simple string representation
      // En producción, usarías json.decode()
      return null;
    } catch (e) {
      return null;
    }
  }
}
