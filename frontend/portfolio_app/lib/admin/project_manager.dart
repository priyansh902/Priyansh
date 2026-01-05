
import 'package:flutter/material.dart';
import 'package:portfolio_app/admin/project_form.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import '../core/api_service.dart';


class ProjectManager extends StatefulWidget {
  const ProjectManager({super.key});

  @override
  State<ProjectManager> createState() => _ProjectManagerState();
}

class _ProjectManagerState extends State<ProjectManager> {
  final api = ApiService();
  List projects = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProjects();
  }

  Future<void> loadProjects() async {
    final data = await api.get('/api/public/projects');
    setState(() {
      projects = data['content'];
      loading = false;
    });
  }

  Future<void> deleteProject(int id) async {
    final token = context.read<AuthService>().token!;
    await api.delete('/api/admin/projects/$id', token: token);
    await loadProjects(); // 🔥 IMPORTANT
  }

  void openForm({Map? project}) {
    showDialog(
      context: context,
      builder: (_) => ProjectForm(
        project: project,
        onSaved: loadProjects, // 🔥 IMPORTANT
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        ElevatedButton(
          onPressed: () => openForm(),
          child: const Text('Add Project'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (_, i) {
              final p = projects[i];
              return Card(
                child: ListTile(
                  title: Text(p['title']),
                  subtitle: Text(p['techStack'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => openForm(project: p),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteProject(p['id']),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
