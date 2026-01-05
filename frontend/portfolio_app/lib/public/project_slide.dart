
import 'package:flutter/material.dart';
import 'package:portfolio_app/public/project_detail_screen.dart';
import '../../core/api_service.dart';

class ProjectsSlide extends StatefulWidget {
  const ProjectsSlide({super.key});

  @override
  State<ProjectsSlide> createState() => _ProjectsSlideState();
}

class _ProjectsSlideState extends State<ProjectsSlide> {
  final api = ApiService();
  final searchCtrl = TextEditingController();

  List allProjects = [];
  List filteredProjects = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProjects();
    searchCtrl.addListener(applyFilter);
  }

  Future<void> loadProjects() async {
    final data =
        await api.get('/api/public/projects?page=0&size=50');

    setState(() {
      allProjects = data['content'];
      filteredProjects = allProjects;
      loading = false;
    });
  }

  void applyFilter() {
    final q = searchCtrl.text.toLowerCase();

    setState(() {
      filteredProjects = allProjects.where((p) {
        return p['title'].toLowerCase().contains(q) ||
            (p['description'] ?? '')
                .toLowerCase()
                .contains(q) ||
            (p['techStack'] ?? '')
                .toLowerCase()
                .contains(q);
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
              hintText: 'Search projects...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: filteredProjects.isEmpty
              ? const Center(child: Text('No projects found'))
              : ListView.builder(
                  itemCount: filteredProjects.length,
                  itemBuilder: (_, i) {
                    final p = filteredProjects[i];
                    return Card(
                      child: ListTile(
                        title: Text(p['title']),
                       
                        subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              p['description'] ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        trailing:
                            const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProjectDetailScreen(project: p),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
