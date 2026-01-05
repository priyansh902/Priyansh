import 'package:flutter/material.dart';
import 'package:portfolio_app/public/contact_slide.dart';
import 'package:portfolio_app/public/profile_slide.dart';
import 'package:portfolio_app/public/project_slide.dart';
import 'package:portfolio_app/public/skill_slide.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = const [
      ProfileSlide(),
      SkillsSlide(),
      ProjectsSlide(),
      ContactSlide(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
      ),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            tooltip: 'Profile',
             label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            tooltip: 'Skills',
            label: 'Skills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            tooltip: 'Projects',
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            tooltip: 'Contact',
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}
