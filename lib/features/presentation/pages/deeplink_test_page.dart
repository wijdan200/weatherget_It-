import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

class DeepLinkTestPage extends StatelessWidget {
  const DeepLinkTestPage({super.key});

  Future<void> _testDeepLink(String uriString) async {
    try {
      final Uri uri = Uri.parse(uriString);
      debugPrint('🧪 Testing deep link: $uriString');

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        debugPrint('✅ Launched: $uriString');
      } else {
        debugPrint('❌ Cannot launch: $uriString');
        // Show error
      }
    } catch (e) {
      debugPrint('❌ Error launching $uriString: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deep Link Test'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Card(
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🧪 Deep Link Testing',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Click buttons below to test deep links. Check console for debug messages.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildTestButton(
            context,
            'Test Weather Page',
            'WeatherApp://open/weather',
            Icons.wb_sunny,
            Colors.orange,
          ),
          _buildTestButton(
            context,
            'Test Dashboard',
            'WeatherApp://open/dashboard',
            Icons.dashboard,
            Colors.blue,
          ),
          _buildTestButton(
            context,
            'Test Notify Page',
            'WeatherApp://open/notify',
            Icons.notifications,
            Colors.green,
          ),
          _buildTestButton(
            context,
            'Test Another Page',
            'WeatherApp://open/another',
            Icons.pages,
            Colors.purple,
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          const Text(
            'Direct Navigation (For Testing)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () => context.go('/weather'),
            icon: const Icon(Icons.wb_sunny),
            label: const Text('Go to Weather (Direct)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => context.go('/dashboard'),
            icon: const Icon(Icons.dashboard),
            label: const Text('Go to Dashboard (Direct)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => context.go('/notify'),
            icon: const Icon(Icons.notifications),
            label: const Text('Go to Notify (Direct)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestButton(
    BuildContext context,
    String label,
    String uri,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: color, size: 32),
        title: Text(label),
        subtitle: Text(
          uri,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'lato',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () => _testDeepLink(uri),
      ),
    );
  }
}
