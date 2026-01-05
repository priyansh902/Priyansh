import 'package:flutter/material.dart';
import 'package:portfolio_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../core/api_service.dart';


class ProfileSlide extends StatefulWidget {
  const ProfileSlide({super.key});

  @override
  State<ProfileSlide> createState() => _ProfileSlideState();
}

class _ProfileSlideState extends State<ProfileSlide> {
  final api = ApiService();
  Map? profile;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final data = await api.get('/api/public/profile');
    setState(() {
      profile = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profile == null) {
      return const Center(child: Text('Profile not set'));
    }
    

    return Center(

      
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             IconButton(
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              tooltip: 'Toggle theme',
              onPressed: () {
                context.read<ThemeProvider>().toggle();
              },
            ),

    const SizedBox(height: 12),
            CircleAvatar(
              radius: 42,
              backgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
              child: const Icon(Icons.person, size: 42),
            ),
            const SizedBox(height: 16),

            Text(
              profile!['name'] ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              profile!['title'] ?? '',
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              profile!['bio'] ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(height: 1.5),
            ),

            const SizedBox(height: 24),

            if (profile!['location'] != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 6),
                  Text(profile!['location']),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
