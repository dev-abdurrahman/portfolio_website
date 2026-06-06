import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    final int currentYear = DateTime.now().year;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF080808),
        border: Border(
          top: BorderSide(
            color: AppTheme.primaryAccent.withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 80,
      ),
      child: Column(
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _brandSection(isMobile),
                const SizedBox(height: 50),
                _footerSectionsMobile(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _brandSection(isMobile)),
                const SizedBox(width: 50),
                Expanded(flex: 2, child: _linksSection('Navigation', ['Home', 'About', 'Services', 'Work', 'My Apps'], isMobile)),
                Expanded(flex: 2, child: _linksSection('Offerings', ['WordPress Dev', 'Flutter Apps', 'LMS Solutions', 'Maintenance'], isMobile)),
                Expanded(flex: 3, child: _contactQuickSection(isMobile)),
              ],
            ),
          const SizedBox(height: 80),
          const Divider(color: Colors.white10, thickness: 1),
          const SizedBox(height: 40),
          isMobile
              ? Column(
                  children: [
                    _socialIconsRow(),
                    const SizedBox(height: 30),
                    _copyrightText(currentYear),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _copyrightText(currentYear),
                    _socialIconsRow(),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _brandSection(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          text: const TextSpan(
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),
            children: [
              TextSpan(text: 'Abdur '),
              TextSpan(text: 'Rahman', style: TextStyle(color: AppTheme.primaryAccent)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 350,
          child: Text(
            'Crafting high-performance Flutter applications and premium WordPress experiences with a focus on clean code and user-centric design.',
            textAlign: isMobile ? TextAlign.center : TextAlign.justify,
            style: TextStyle(
              color: AppTheme.textMuted,
              height: 1.6,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _linksSection(String title, List<String> links, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 25),
        ...links.map((link) => _FooterLink(label: link, isCentered: isMobile)),
      ],
    );
  }

  Widget _contactQuickSection(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const Text(
          'GET IN TOUCH',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 25),
        _contactItem(Icons.email_outlined, 'abdurrahmansadik02@gmail.com', isMobile),
        const SizedBox(height: 15),
        _contactItem(Icons.phone_outlined, '+880 1887-160053', isMobile),
      ],
    );
  }

  Widget _contactItem(IconData icon, String text, bool isMobile) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.primaryAccent, size: 16),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerSectionsMobile() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _linksSection('Navigation', ['Home', 'About', 'Services', 'Work', 'My Apps'], true)),
            Expanded(child: _linksSection('Offerings', ['WordPress Dev', 'Flutter Apps', 'LMS Solutions'], true)),
          ],
        ),
        const SizedBox(height: 40),
        _contactQuickSection(true),
      ],
    );
  }

  Widget _copyrightText(int year) {
    return Text(
      '© $year Abdur Rahman. Built with Flutter.',
      textAlign: TextAlign.center,
      style: const TextStyle(color: AppTheme.textMuted, fontSize: 14),
    );
  }

  Widget _socialIconsRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIcon(
          icon: Icons.facebook,
          onTap: () => _launchUrl('https://www.facebook.com/abdurrahmansadik01/'),
        ),
        _SocialIcon(
          icon: Icons.chat_bubble_outline,
          onTap: () => _launchUrl('https://wa.me/8801887160053'),
        ),
        _SocialIcon(
          icon: Icons.play_circle_outline,
          onTap: () {}, // YouTube link placeholder
        ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final bool isCentered;
  const _FooterLink({required this.label, this.isCentered = false});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(left: (_isHovered && !widget.isCentered) ? 8 : 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: widget.isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              if (_isHovered && !widget.isCentered)
                const Icon(Icons.arrow_right, color: AppTheme.primaryAccent, size: 16),
              Text(
                widget.label,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: _isHovered ? AppTheme.primaryAccent : AppTheme.textMuted,
                  fontSize: 15,
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SocialIcon({required this.icon, required this.onTap});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 7),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.primaryAccent : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? Colors.black : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
