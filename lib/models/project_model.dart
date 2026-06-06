import 'package:flutter/material.dart';

enum ProjectType { website, app }

class ProjectModel {
  final String title;
  final String description;
  final String tag;
  final String liveUrl;
  final String githubUrl;
  final String? apkUrl;
  final List<Color> gradient;
  final ProjectType type;
  final bool isPopular;

  ProjectModel({
    required this.title,
    required this.description,
    required this.tag,
    required this.liveUrl,
    required this.githubUrl,
    this.apkUrl,
    required this.gradient,
    required this.type,
    this.isPopular = false,
  });
}

final List<ProjectModel> projects = [
  ProjectModel(
    title: 'LuxeCart',
    description: 'Full WooCommerce fashion store with custom theme integration.',
    tag: 'WooCommerce',
    liveUrl: 'https://example.com/luxecart',
    githubUrl: 'https://github.com/example/luxecart',
    gradient: [const Color(0xFF4A148C), const Color(0xFF0D47A1)],
    type: ProjectType.website,
  ),
  ProjectModel(
    title: 'FitTrack',
    description: 'Complete workout tracking app with real-time Firebase sync.',
    tag: 'Flutter, Firebase',
    liveUrl: 'https://example.com/fittrack',
    githubUrl: 'https://github.com/example/fittrack',
    apkUrl: 'https://github.com/YOUR_USERNAME/REPO_NAME/releases/download/v1.0.0/fittrack.apk',
    gradient: [const Color(0xFF006064), const Color(0xFF0097A7)],
    type: ProjectType.app,
    isPopular: true,
  ),
  ProjectModel(
    title: 'EduLearn',
    description: 'LMS portal built with WordPress for online education.',
    tag: 'WordPress, LMS',
    liveUrl: 'https://example.com/edulearn',
    githubUrl: 'https://github.com/example/edulearn',
    gradient: [const Color(0xFF1B5E20), const Color(0xFF004D40)],
    type: ProjectType.website,
  ),
  ProjectModel(
    title: 'Taskly Pro',
    description: 'Task management app with Kanban board and local storage.',
    tag: 'Flutter',
    liveUrl: 'https://example.com/taskly',
    githubUrl: 'https://github.com/example/taskly',
    apkUrl: 'https://github.com/YOUR_USERNAME/REPO_NAME/releases/download/v1.0.0/taskly.apk',
    gradient: [const Color(0xFFE65100), const Color(0xFFFF6F00)],
    type: ProjectType.app,
    isPopular: true,
  ),
  ProjectModel(
    title: 'EstateFlow',
    description: 'Real estate broker listing site with advanced filtering.',
    tag: 'WordPress',
    liveUrl: 'https://example.com/estateflow',
    githubUrl: 'https://github.com/example/estateflow',
    gradient: [const Color(0xFF004D40), const Color(0xFF00695C)],
    type: ProjectType.website,
  ),
  ProjectModel(
    title: 'Bazaar Express',
    description: 'Online delivery app with live tracking and secure payments.',
    tag: 'Flutter, Firebase',
    liveUrl: 'https://example.com/bazaar',
    githubUrl: 'https://github.com/example/bazaar',
    apkUrl: 'https://github.com/YOUR_USERNAME/REPO_NAME/releases/download/v1.0.0/bazaar.apk',
    gradient: [const Color(0xFF880E4F), const Color(0xFF4A148C)],
    type: ProjectType.app,
    isPopular: true,
  ),
];
