import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class Navbar extends StatelessWidget {
  final bool isScrolled;
  final Function(int) onNavTap;

  const Navbar({super.key, required this.isScrolled, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 80,
          decoration: BoxDecoration(
            color: isScrolled ? AppTheme.bgColor.withOpacity(0.8) : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isScrolled ? AppTheme.primaryAccent.withOpacity(0.1) : Colors.transparent,
                width: 1,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : (MediaQuery.of(context).size.width < 1100 ? 40 : 100)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: AppTheme.headingStyle.copyWith(fontSize: 24, letterSpacing: -0.5),
                    children: const [
                      TextSpan(text: 'Abdur '),
                      TextSpan(
                        text: 'Rahman',
                        style: TextStyle(color: AppTheme.primaryAccent),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isMobile)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _navItem('Home', 0),
                    _navItem('About', 1),
                    _navItem('Services', 2),
                    _navItem('Work', 3),
                    _navItem('My Apps', 5),
                    const SizedBox(width: 20),
                    _ctaButton(),
                  ],
                )
              else
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(String title, int index) {
    return InkWell(
      onTap: () => onNavTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _ctaButton() {
    return ElevatedButton(
      onPressed: () => onNavTap(4),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.primaryAccent,
        side: const BorderSide(color: AppTheme.primaryAccent, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
      child: const Text(
        "Let's Talk",
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }
}
