import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    bool isTablet = MediaQuery.of(context).size.width < 1200 && MediaQuery.of(context).size.width >= 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 120,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardBg.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'WHAT I OFFER',
            style: TextStyle(
              color: AppTheme.primaryAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          Text('My Services',
              style: AppTheme.headingStyle.copyWith(fontSize: isMobile ? 32 : 48)),
          const SizedBox(height: 80),
          // Using a more flexible layout for mobile, and grid for desktop
          isMobile
              ? Column(
                  children: _getServiceCards(),
                )
              : GridView.count(
                  crossAxisCount: isTablet ? 2 : 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                  // Taller aspect ratio to prevent bottom overflow
                  childAspectRatio: isTablet ? 0.75 : 0.65,
                  children: _getServiceCards(),
                ),
        ],
      ),
    );
  }

  List<Widget> _getServiceCards() {
    return const [
      ServiceCard(
        icon: Icons.code, // Better for development context
        title: 'WordPress Development',
        description:
            'Custom themes, plugins, and high-converting WooCommerce stores tailored for your business.',
        bullets: [
          'Custom Theme & Plugin Dev',
          'WooCommerce Store Expert',
          'Page Speed Optimization',
        ],
      ),
      ServiceCard(
        icon: Icons.flutter_dash,
        title: 'Flutter App Development',
        description:
            'High-performance iOS & Android native apps with a single codebase and clean architecture.',
        bullets: [
          'Native Android & iOS Apps',
          'Firebase & API Integration',
          'State Management (Bloc/Provider)',
        ],
      ),
      ServiceCard(
        icon: Icons.auto_fix_high, // Better for maintenance/support context
        title: 'Maintenance & Support',
        description:
            'Keep your digital products online, updated, and blazing fast with 24/7 expert monitoring.',
        bullets: [
          '24/7 Security Monitoring',
          'Automated Offsite Backups',
          'Emergency Bug Fixes',
        ],
      ),
    ];
  }
}

class ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> bullets;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.bullets,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: isMobile ? const EdgeInsets.only(bottom: 30) : EdgeInsets.zero,
        padding: const EdgeInsets.all(35),
        decoration: BoxDecoration(
          color: AppTheme.cardBgSecondary,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryAccent.withOpacity(0.5)
                : Colors.white.withOpacity(0.05),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppTheme.primaryAccent.withOpacity(0.15)
                  : Colors.black.withOpacity(0.2),
              blurRadius: _isHovered ? 40 : 20,
              spreadRadius: _isHovered ? 5 : 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with Glow Backdrop
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppTheme.primaryAccent
                    : AppTheme.primaryAccent.withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: _isHovered ? [
                  BoxShadow(
                    color: AppTheme.primaryAccent.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ] : [],
              ),
              child: Icon(widget.icon,
                  color: _isHovered ? Colors.black : AppTheme.primaryAccent,
                  size: 32),
            ),
            const SizedBox(height: 30),
            Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5),
            ),
            const SizedBox(height: 15),
            Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 15,
                  height: 1.5),
            ),
            const SizedBox(height: 30),
            const Divider(color: Colors.white10, height: 1),
            const SizedBox(height: 25),
            ...widget.bullets.map((bullet) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // FIXED: Align to start
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(Icons.check_circle,
                            color: AppTheme.primaryAccent, size: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Text(bullet,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                  height: 1.4))),
                    ],
                  ),
                )),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}
