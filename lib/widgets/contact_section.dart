import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  String _projectType = 'Website';
  bool _isSubmitHovered = false;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 120,
      ),
      child: Column(
        children: [
          const Text(
            "LET'S CONNECT",
            style: TextStyle(
              color: AppTheme.primaryAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          Text('Contact Me',
              style: AppTheme.headingStyle.copyWith(fontSize: isMobile ? 32 : 48)),
          const SizedBox(height: 80),
          isMobile
              ? Column(
                  children: [
                    _buildContactInfo(isMobile),
                    const SizedBox(height: 80),
                    _buildContactForm(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactInfo(isMobile)),
                    const SizedBox(width: 80),
                    Expanded(flex: 2, child: _buildContactForm()),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Have a project in mind?',
          style: TextStyle(
            fontSize: isMobile ? 26 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'I am available for freelance work and full-time opportunities. Reach out to me and let\'s build something amazing together.',
          textAlign: isMobile ? TextAlign.center : TextAlign.justify,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: isMobile ? 16 : 18,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 50),
        _infoItem(Icons.email_outlined, 'Email', 'abdurrahmansadik02@gmail.com'),
        _infoItem(Icons.location_on_outlined, 'Location', 'Kushtia, Bangladesh'),
        _infoItem(Icons.access_time_outlined, 'Working Hours', 'Daily, 7:00 AM - 10:00 PM'),
        const SizedBox(height: 40),
        const Text(
          'Connect with me:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            _socialBadge(Icons.facebook, 'Facebook', () => _launchUrl('https://www.facebook.com/abdurrahmansadik01/')),
            _socialBadge(Icons.play_circle_outline, 'YouTube', () {}),
            _socialBadge(Icons.chat_bubble_outline, 'WhatsApp', () => _launchUrl('https://wa.me/8801887160053')),
          ],
        ),
      ],
    );
  }

  Widget _socialBadge(IconData icon, String tooltip, VoidCallback onTap) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primaryAccent.withOpacity(0.2)),
            ),
            child: Icon(icon, color: AppTheme.primaryAccent, size: 22),
          ),
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryAccent, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 13)),
                const SizedBox(height: 4),
                Text(value,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          isMobile
              ? Column(
                  children: [
                    _textField('Your Name'),
                    const SizedBox(height: 20),
                    _textField('Email Address'),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _textField('Your Name')),
                    const SizedBox(width: 20),
                    Expanded(child: _textField('Email Address')),
                  ],
                ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: _projectType,
            dropdownColor: AppTheme.cardBgSecondary,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.primaryAccent),
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: _inputDecoration('Project Type'),
            items: ['Website', 'Mobile App', 'UI/UX Design', 'Other']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) => setState(() => _projectType = val!),
          ),
          const SizedBox(height: 20),
          _textField('Detailed Message', maxLines: 5),
          const SizedBox(height: 40),
          MouseRegion(
            onEnter: (_) => setState(() => _isSubmitHovered = true),
            onExit: (_) => setState(() => _isSubmitHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: _isSubmitHovered ? [
                  BoxShadow(
                    color: AppTheme.primaryAccent.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ] : [],
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Message Sent Successfully!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryAccent,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 65),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Send Message',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(width: 10),
                    const Icon(Icons.send_rounded, size: 20)
                        .animate(target: _isSubmitHovered ? 1 : 0)
                        .moveX(begin: 0, end: 5)
                        .fadeIn(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(String label, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(label),
      validator: (val) =>
          val == null || val.isEmpty ? 'Please enter your $label' : null,
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
      floatingLabelStyle: const TextStyle(color: AppTheme.primaryAccent),
      filled: true,
      fillColor: AppTheme.cardBgSecondary.withOpacity(0.5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.primaryAccent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }
}
