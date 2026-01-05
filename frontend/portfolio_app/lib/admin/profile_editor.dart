
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import '../core/api_service.dart';

class ProfileEditor extends StatefulWidget {
  const ProfileEditor({super.key});

  @override
  State<ProfileEditor> createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {
  final api = ApiService();

  final name = TextEditingController();
  final title = TextEditingController();
  final bio = TextEditingController();
  final location = TextEditingController();
  final email = TextEditingController();
  final github = TextEditingController();
  final linkedin = TextEditingController();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await api.get('/api/public/profile');
    if (data != null) {
      name.text = data['name'] ?? '';
      title.text = data['title'] ?? '';
      bio.text = data['bio'] ?? '';
      location.text = data['location'] ?? '';
      email.text = data['email'] ?? '';
      github.text = data['githubUrl'] ?? '';
      linkedin.text = data['linkedinUrl'] ?? '';
    }
    setState(() => loading = false);
  }

  Future<void> save() async {
    final token = context.read<AuthService>().token!;
    await api.put(
      '/api/admin/profile',
      {
        'name': name.text,
        'title': title.text,
        'bio': bio.text,
        'location': location.text,
        'email': email.text,
        'githubUrl': github.text,
        'linkedinUrl': linkedin.text,
      },
      token: token,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _field(name, 'Name'),
          _field(title, 'Title'),
          _field(bio, 'Bio', lines: 3),
          _field(location, 'Location'),
          _field(email, 'Email'),
          _field(github, 'GitHub URL'),
          _field(linkedin, 'LinkedIn URL'),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: save, child: const Text('Save Profile')),
        ],
      ),
    );
  }

  Widget _field(TextEditingController c, String label, {int lines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        maxLines: lines,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
