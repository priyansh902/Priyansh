import 'package:flutter/material.dart';
import 'package:portfolio_app/admin/contact_message.dart';


import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import 'profile_editor.dart';
import 'project_manager.dart';
import 'skill_manager.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int index = 0;

  final pages = const [
    ProfileEditor(),
    ProjectManager(),
    SkillManager(),
    ContactMessages(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin CMS'),
        actions: [
          // LOGOUT (ADMIN)
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Back to Login Screen',
            onPressed: () {
              context.read<AuthService>().logout();
            },
          ),
        ],
      ),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            tooltip: 'Profile Screen',
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            tooltip: 'Projects Screen',
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            tooltip: 'Skill Screen',
            label: 'Skills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            tooltip: 'Contact Screen',
            label: 'Messages',
          ),
        ],
      ),
    );
  }
}
