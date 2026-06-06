import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';
import '../theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: _isHovered 
            ? (Matrix4.identity()..translate(0, -10)) 
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              widget.project.gradient[0].withOpacity(0.9),
              widget.project.gradient[1].withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: _isHovered ? AppTheme.primaryAccent.withOpacity(0.5) : Colors.white.withOpacity(0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (_isHovered ? widget.project.gradient[0] : Colors.black).withOpacity(_isHovered ? 0.4 : 0.4),
              blurRadius: _isHovered ? 40 : 15,
              offset: Offset(0, _isHovered ? 15 : 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Glass effect overlay
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.02),
                ),
              ),
              // Optional: Background Icon/Shape for extra flair
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  widget.project.type == ProjectType.app ? Icons.phone_android : Icons.web,
                  size: 150,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        widget.project.tag,
                        style: const TextStyle(
                          color: AppTheme.primaryAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.project.title,
                            style: AppTheme.headingStyle.copyWith(fontSize: 26, letterSpacing: -0.5),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (_isHovered)
                          const Icon(Icons.arrow_forward_rounded, color: AppTheme.primaryAccent)
                              .animate()
                              .moveX(begin: -10, end: 0)
                              .fadeIn(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.project.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 15,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        _actionButton(Icons.launch, 'Live Demo', () => _launchUrl(widget.project.liveUrl)),
                        const SizedBox(width: 20),
                        _actionButton(Icons.code, 'GitHub', () => _launchUrl(widget.project.githubUrl)),
                      ],
                    ),
                    if (widget.project.apkUrl != null) ...[
                      const SizedBox(height: 15),
                      _apkButton(context),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 500.ms),
    );
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppTheme.primaryAccent),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold, 
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _apkButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            await _launchUrl(widget.project.apkUrl!);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('APK ডাউনলোড হচ্ছে...')),
              );
            }
          },
          icon: const Icon(Icons.download, size: 18),
          label: const Text('INSTALL APK', style: TextStyle(fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryAccent,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 45),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: _isHovered ? 10 : 0,
            shadowColor: AppTheme.primaryAccent.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Android only • Enable Unknown Sources',
          style: TextStyle(color: Colors.white38, fontSize: 10),
        ),
      ],
    );
  }
}
