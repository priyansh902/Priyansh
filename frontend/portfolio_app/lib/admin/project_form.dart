import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import '../core/api_service.dart';

class ProjectForm extends StatefulWidget {
  final Map? project;
  final VoidCallback onSaved;

  const ProjectForm({super.key, this.project, required this.onSaved});

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final api = ApiService();

  final title = TextEditingController();
  final desc = TextEditingController();
  final tech = TextEditingController();
  bool featured = false;

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      final p = widget.project!;
      title.text = p['title'];
      desc.text = p['description'];
      tech.text = p['techStack'];
      featured = p['featured'] ?? false;
    }
  }

  Future<void> save() async {
    final token = context.read<AuthService>().token!;
    final body = {
      'title': title.text,
      'description': desc.text,
      'techStack': tech.text,
      'featured': featured,
    };

    if (widget.project == null) {
      await api.post('/api/admin/projects', body, token: token);
    } else {
      await api.put(
        '/api/admin/projects/${widget.project!['id']}',
        body,
        token: token,
      );
    }

    widget.onSaved(); // 🔥 REFRESH LIST
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.project == null ? 'Add Project' : 'Edit Project'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')),
          TextField(controller: desc, decoration: const InputDecoration(labelText: 'Description')),
          TextField(controller: tech, decoration: const InputDecoration(labelText: 'Tech Stack')),
          CheckboxListTile(
            value: featured,
            onChanged: (v) => setState(() => featured = v!),
            title: const Text('Featured'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: save, child: const Text('Save')),
      ],
    );
  }
}
