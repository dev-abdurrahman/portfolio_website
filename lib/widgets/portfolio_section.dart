import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../theme/app_theme.dart';
import 'project_card.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({super.key});

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    List<ProjectModel> filteredProjects = projects.where((p) {
      // Only show popular apps in the Work section
      if (p.type == ProjectType.app && !p.isPopular) return false;
      
      if (_selectedFilter == 'All') return true;
      if (_selectedFilter == 'Websites') return p.type == ProjectType.website;
      if (_selectedFilter == 'Apps') return p.type == ProjectType.app;
      return true;
    }).toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          const Text(
            'FEATURED WORK',
            style: TextStyle(
              color: AppTheme.primaryAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          Text('My Portfolio', style: AppTheme.headingStyle.copyWith(fontSize: isMobile ? 32 : 48)),
          const SizedBox(height: 60),
          // Interactive Tab Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['All', 'Websites', 'Apps']
                .map((filter) => _filterTab(filter))
                .toList(),
          ),
          const SizedBox(height: 60),
          // Mobile: Column of cards (natural height), Desktop: GridView with fixed aspect ratio
          if (isMobile)
            Column(
              children: filteredProjects.asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key < filteredProjects.length - 1 ? 30 : 0,
                  ),
                  child: ProjectCard(project: entry.value),
                );
              }).toList(),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: 1.1,
              ),
              itemCount: filteredProjects.length,
              itemBuilder: (context, index) {
                return ProjectCard(project: filteredProjects[index]);
              },
            ),
        ],
      ),
    );
  }

  Widget _filterTab(String label) {
    bool isActive = _selectedFilter == label;
    return _HoverableTab(
      label: label,
      isActive: isActive,
      onTap: () => setState(() => _selectedFilter = label),
    );
  }
}

class _HoverableTab extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _HoverableTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_HoverableTab> createState() => _HoverableTabState();
}

class _HoverableTabState extends State<_HoverableTab> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isActive 
                    ? AppTheme.primaryAccent 
                    : (_isHovered ? AppTheme.primaryAccent.withOpacity(0.5) : Colors.transparent),
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isActive 
                  ? AppTheme.primaryAccent 
                  : (_isHovered ? Colors.white : Colors.white60),
              fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
