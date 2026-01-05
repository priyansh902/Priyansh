import 'package:flutter/material.dart';



class SkillDetailScreen extends StatelessWidget {
  final Map skill;

  const SkillDetailScreen({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(skill['name']),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //  ICON
              CircleAvatar(
                radius: 36,
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                child: const Icon(Icons.code, size: 32),
              ),

              const SizedBox(height: 16),

              //  NAME
              Text(
                skill['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              //  CATEGORY
              Card(
                child: ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('Category'),
                  subtitle: Text(skill['category']),
                ),
              ),

              const SizedBox(height: 12),

              //  LEVEL
              Card(
                child: ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: const Text('Level'),
                  subtitle: Text(skill['level']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
