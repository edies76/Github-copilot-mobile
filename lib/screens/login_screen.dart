import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _tokenController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 48),
                
                // Logo/Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.code,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Title
                Text(
                  'GitHub Copilot Mobile',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 12),
                
                // Subtitle
                Text(
                  'Your AI-powered coding assistant',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 48),
                
                // Token Input
                TextField(
                  controller: _tokenController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'GitHub Personal Access Token',
                    hintText: 'ghp_xxxxxxxxxxxxxxxxxxxx',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.key),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Helper text
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Get your token from: github.com/settings/tokens',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Login Button
                Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : () => _handleLogin(context, authProvider),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: authProvider.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Login with GitHub',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Demo Mode Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _handleDemoMode(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Try Demo Mode'),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Error message
                Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    if (authProvider.error != null) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Text(
                          authProvider.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context, AuthProvider authProvider) async {
    if (_tokenController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your GitHub token')),
      );
      return;
    }

    final success = await authProvider.login(_tokenController.text);
    if (success && mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void _handleDemoMode(BuildContext context) {
    // Para demo, usamos un token simulado
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Demo mode enabled')),
    );
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
