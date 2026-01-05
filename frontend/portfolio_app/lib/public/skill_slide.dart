
import 'package:flutter/material.dart';
import 'package:portfolio_app/public/skill_detail_screen.dart';
import '../../core/api_service.dart';

class SkillsSlide extends StatefulWidget {
  const SkillsSlide({super.key});

  @override
  State<SkillsSlide> createState() => _SkillsSlideState();
}

class _SkillsSlideState extends State<SkillsSlide> {
  final api = ApiService();
  final searchCtrl = TextEditingController();

  List allSkills = [];
  List filteredSkills = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadSkills();
    searchCtrl.addListener(applyFilter);
  }

  Future<void> loadSkills() async {
    final data = await api.get('/api/public/skills');

    setState(() {
      allSkills = data as List;
      filteredSkills = allSkills;
      loading = false;
    });
  }

  void applyFilter() {
    final q = searchCtrl.text.toLowerCase();

    setState(() {
      filteredSkills = allSkills.where((s) {
        return s['name'].toLowerCase().contains(q) ||
            s['category'].toLowerCase().contains(q) ||
            s['level'].toLowerCase().contains(q);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: searchCtrl,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search skills...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: filteredSkills.isEmpty
              ? const Center(child: Text('No skills found'))
              : ListView.builder(
                  itemCount: filteredSkills.length,
                  itemBuilder: (_, i) {
                    final s = filteredSkills[i];
                 
                  return Card(
                    child: ListTile(
                      title: Text(
                        s['name'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text('${s['category']} • ${s['level']}'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SkillDetailScreen(skill: s),
                          ),
                        );
                      },
                    ),
                  );
                  }
                ),
        ),
      ],
    );
  }
}
