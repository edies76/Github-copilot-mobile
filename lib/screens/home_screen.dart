import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/chat_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Copilot Mobile'),
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Greeting
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  final user = authProvider.currentUser;
                  return Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back, ${user?.name?.split(' ').first ?? 'Developer'}!',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your AI-powered coding assistant is ready to help you write better code, faster.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              
              // Quick Actions
              Text(
                'Quick Actions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _QuickActionCard(
                    icon: Icons.code,
                    title: 'Code Completion',
                    description: 'Get AI suggestions',
                    onTap: () => _navigateToChat(context, 'code completion'),
                  ),
                  _QuickActionCard(
                    icon: Icons.bug_report,
                    title: 'Debug Code',
                    description: 'Find and fix issues',
                    onTap: () => _navigateToChat(context, 'debug code'),
                  ),
                  _QuickActionCard(
                    icon: Icons.description,
                    title: 'Documentation',
                    description: 'Generate docs',
                    onTap: () => _navigateToChat(context, 'generate documentation'),
                  ),
                  _QuickActionCard(
                    icon: Icons.lightbulb,
                    title: 'Code Review',
                    description: 'Get suggestions',
                    onTap: () => _navigateToChat(context, 'code review'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Features Section
              Text(
                'Features',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              _FeatureCard(
                icon: Icons.auto_awesome,
                title: 'AI-Powered Suggestions',
                description: 'Get intelligent code suggestions powered by GitHub Copilot',
              ),
              const SizedBox(height: 8),
              _FeatureCard(
                icon: Icons.storage,
                title: 'Local Storage',
                description: 'All your conversations are saved locally on your device',
              ),
              const SizedBox(height: 8),
              _FeatureCard(
                icon: Icons.security,
                title: 'Secure Authentication',
                description: 'Your GitHub token is stored securely with encryption',
              ),
              const SizedBox(height: 24),
              
              // Tips Section
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Pro Tips',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Be specific in your questions for better suggestions\n'
                      '• Include code snippets for debugging assistance\n'
                      '• Use natural language to describe what you need\n'
                      '• Save important conversations for future reference',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToChat(BuildContext context, String topic) {
    // Navegar a la pantalla de chat y enviar un mensaje inicial
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting: $topic')),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
