import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isVisible = false;
  bool _isImageHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 100,
          vertical: isMobile ? 60 : 120,
        ),
        child: Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            const Text(
              'WHO I AM',
              style: TextStyle(
                color: AppTheme.primaryAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),
            Text('About Me',
                style: AppTheme.headingStyle
                    .copyWith(fontSize: isMobile ? 32 : 48)),
            const SizedBox(height: 60),
            isMobile
                ? Column(
                    children: [
                      _buildAboutContent(true), // Content first in mobile
                      const SizedBox(height: 50),
                      _buildAboutImage(true), // Image after content
                      const SizedBox(height: 40),
                      _buildDecorativeQuote().animate().fadeIn(delay: 1.seconds),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildAboutImage(false),
                            const SizedBox(height: 40),
                            _buildDecorativeQuote().animate().fadeIn(delay: 1.seconds),
                          ],
                        ),
                      ),
                      const SizedBox(width: 80),
                      Expanded(
                        flex: 1,
                        child: _buildAboutContent(false),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecorativeQuote() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryAccent.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          const Icon(Icons.format_quote, color: AppTheme.primaryAccent, size: 30),
          const SizedBox(height: 10),
          Text(
            "Design is not just what it looks like and feels like. Design is how it works.",
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutImage(bool isMobile) {
    double size = isMobile ? 300 : 450;
    return MouseRegion(
      onEnter: (_) => setState(() => _isImageHovered = true),
      onExit: (_) => setState(() => _isImageHovered = false),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Decorative Glow Backdrop
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: size * 0.9,
              height: size * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryAccent.withOpacity(_isImageHovered ? 0.3 : 0.1),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
            // Main Image Container with Frame
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: size,
              width: size * 0.85,
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppTheme.primaryAccent.withOpacity(_isImageHovered ? 0.6 : 0.2),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Stack(
                  children: [
                    AnimatedScale(
                      scale: _isImageHovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 600),
                      child: Image.asset(
                        'assets/images/about-photo.png',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    // Gradient Overlay for depth
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Floating Developer Badge (Top Right)
            Positioned(
              top: -10,
              right: -10,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryAccent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryAccent.withOpacity(0.4),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: const Icon(Icons.terminal_rounded, color: Colors.black, size: 22),
              ).animate(target: _isImageHovered ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
            ),
            // Experience Badge (Bottom Left)
            Positioned(
              bottom: 20,
              left: -20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.cardBgSecondary,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppTheme.primaryAccent.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Text(
                      '50+',
                      style: TextStyle(
                        color: AppTheme.primaryAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Projects Done',
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ).animate().slideX(begin: -0.2, end: 0, duration: 800.ms),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms);
  }

  Widget _buildAboutContent(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Crafting Digital Products with Precision',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.3,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'I am Abdur Rahman, a passionate developer based in Bangladesh. With over 5 years of experience, I specialize in WordPress, WooCommerce, and Flutter app development. My goal is to help businesses grow by providing robust, scalable, and user-friendly digital solutions.',
          textAlign: isMobile ? TextAlign.center : TextAlign.justify,
          style: TextStyle(
            color: const Color(0xFFCBD5E1),
            fontSize: isMobile ? 16 : 18,
            height: 1.8,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 50),
        _skillBar('WordPress Development', 0.95),
        _skillBar('Flutter App Development', 0.90),
        _skillBar('Custom API Integrations', 0.85),
        const SizedBox(height: 50),
        const Text(
          'Technologies I use:',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
        const SizedBox(height: 25),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: [
            _skillBadge(Icons.wordpress, 'WordPress', Colors.blue),
            _skillBadge(Icons.flutter_dash, 'Flutter', Colors.cyan),
            _skillBadge(Icons.shopping_cart, 'WooCommerce', Colors.purple),
            _skillBadge(Icons.code, 'Dart', Colors.blueAccent),
            _skillBadge(Icons.api, 'REST APIs', Colors.orange),
            _skillBadge(Icons.storage, 'Firebase', Colors.amber),
          ],
        ),
      ],
    );
  }

  Widget _skillBadge(IconData icon, String label, Color color) {
    return _HoverableSkillBadge(icon: icon, label: label, color: color);
  }

  Widget _skillBar(String label, double percent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Text('${(percent * 100).toInt()}%',
                  style: const TextStyle(
                      color: AppTheme.primaryAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
            ],
          ),
          const SizedBox(height: 10),
          LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 6,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  height: 6,
                  width: _isVisible ? (constraints.maxWidth * percent) : 0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryAccent, Colors.teal],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _HoverableSkillBadge extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _HoverableSkillBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  State<_HoverableSkillBadge> createState() => _HoverableSkillBadgeState();
}

class _HoverableSkillBadgeState extends State<_HoverableSkillBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered ? AppTheme.primaryAccent : AppTheme.cardBg.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isHovered 
                ? AppTheme.primaryAccent 
                : AppTheme.primaryAccent.withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon, 
              color: _isHovered ? Colors.black : widget.color, 
              size: 16
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: TextStyle(
                color: _isHovered ? Colors.black : Colors.white.withOpacity(0.9),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
