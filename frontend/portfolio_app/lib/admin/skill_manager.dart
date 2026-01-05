
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_service.dart';
import '../core/api_service.dart';


class SkillManager extends StatefulWidget {
  const SkillManager({super.key});

  @override
  State<SkillManager> createState() => _SkillManagerState();
}

class _SkillManagerState extends State<SkillManager> {
  final api = ApiService();
  List skills = [];

  final name = TextEditingController();
  String category = 'BACKEND';
  String level = 'INTERMEDIATE';

  @override
  void initState() {
    super.initState();
    loadSkills();
  }

  Future<void> loadSkills() async {
    skills = await api.get('/api/public/skills');
    setState(() {});
  }

  Future<void> addSkill() async {
    final token = context.read<AuthService>().token!;
    await api.post(
      '/api/admin/skills',
      {'name': name.text, 'category': category, 'level': level},
      token: token,
    );
    name.clear();
    await loadSkills(); 
  }

  Future<void> deleteSkill(int id) async {
    final token = context.read<AuthService>().token!;
    await api.delete('/api/admin/skills/$id', token: token);
    await loadSkills(); 
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Skill')),
        DropdownButton<String>(
          value: category,
          items: ['BACKEND','FRONTEND','DEVOPS','DATABASE','OTHER']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => category = v!),
        ),
        DropdownButton<String>(
          value: level,
          items: ['BEGINNER','INTERMEDIATE','ADVANCED']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => level = v!),
        ),
        ElevatedButton(onPressed: addSkill, child: const Text('Add Skill')),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: skills.length,
            itemBuilder: (_, i) {
              final s = skills[i];
              return ListTile(
                title: Text(s['name']),
                subtitle: Text('${s['category']} • ${s['level']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteSkill(s['id']),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
