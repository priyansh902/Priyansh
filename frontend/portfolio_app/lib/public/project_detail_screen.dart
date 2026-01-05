import 'package:flutter/material.dart';




class ProjectDetailScreen extends StatelessWidget {
  final Map project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project['title']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  TITLE
            Text(
              project['title'],
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            //  DESCRIPTION
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  project['description'] ?? 'No description available',
                  style: const TextStyle(height: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 20),

            //  TECH STACK
            Text(
              'Tech Stack',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(project['techStack'] ?? '—'),
              ),
            ),

            const SizedBox(height: 24),

            //  LINKS
            if (project['githubUrl'] != null ||
                project['liveUrl'] != null)
              Text(
                'Links',
                style: Theme.of(context).textTheme.titleMedium,
              ),

            const SizedBox(height: 12),

            if (project['githubUrl'] != null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.code),
                  label: const Text('View GitHub'),
                  onPressed: () {},
                ),
              ),

            if (project['liveUrl'] != null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.launch),
                  label: const Text('Live Demo'),
                  onPressed: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
