import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: isMobile ? 20 : 100,
        right: isMobile ? 20 : 100,
        top: isMobile ? 100 : 140,
        bottom: isMobile ? 60 : 120,
      ),
      child: isMobile
          ? Column(
              children: [
                _buildHeroHeader(true),
                const SizedBox(height: 50),
                _buildProfileImage(true),
                const SizedBox(height: 50),
                _buildHeroDetails(true),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroHeader(false),
                      _buildHeroDetails(false),
                    ],
                  ),
                ),
                const SizedBox(width: 80),
                Expanded(flex: 2, child: _buildProfileImage(false)),
              ],
            ),
    );
  }

  Widget _buildHeroHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        _statusBadge(),
        const SizedBox(height: 25),
        Text(
          'Abdur Rahman',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: AppTheme.headingStyle.copyWith(
            fontSize: isMobile ? 38 : 65,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 45,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: isMobile ? 22 : 28,
              color: AppTheme.primaryAccent,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText('WordPress Expert'),
                TypewriterAnimatedText('Flutter Developer'),
                TypewriterAnimatedText('App Designer'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroDetails(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Text(
          'Building high-performance digital solutions from Bangladesh. We specialize in crafting seamless user experiences across web and mobile platforms.',
          textAlign: isMobile ? TextAlign.center : TextAlign.justify,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: isMobile ? 16 : 18,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 50),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 20,
          runSpacing: 20,
          children: [
            _primaryButton('View Work'),
            _secondaryButton('Hire Me'),
          ],
        ),
      ],
    );
  }

  Widget _primaryButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryAccent,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 10,
        shadowColor: AppTheme.primaryAccent.withOpacity(0.3),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _secondaryButton(String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white.withOpacity(0.5), width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _buildProfileImage(bool isMobile) {
    double size = isMobile ? 260 : 340;
    return Center(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Simplified background for mobile to avoid overflow
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: size,
              height: size * 1.2,
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryAccent.withOpacity(_isHovered ? 0.4 : 0.1),
                    blurRadius: 40,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/images/Abdur_Rahman.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            // Badge placed inside to prevent overflow
            Positioned(
              bottom: 15,
              child: _badge('5+ Years Experience'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.primaryAccent.withOpacity(0.5)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
    );
  }

  Widget _statusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          const Text('Available for Projects', 
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}
