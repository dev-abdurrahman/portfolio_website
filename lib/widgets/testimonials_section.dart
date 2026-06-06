import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;
    bool isTablet = MediaQuery.of(context).size.width < 1200 && MediaQuery.of(context).size.width >= 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 120,
      ),
      color: AppTheme.cardBg.withOpacity(0.3),
      child: Column(
        children: [
          const Text(
            'CLIENT FEEDBACK',
            style: TextStyle(
              color: AppTheme.primaryAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          Text('Testimonials',
              style: AppTheme.headingStyle.copyWith(fontSize: isMobile ? 32 : 48)),
          const SizedBox(height: 80),
          isMobile
              ? Column(
                  children: _getTestimonials(),
                )
              : GridView.count(
                  crossAxisCount: isTablet ? 2 : 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: isTablet ? 0.9 : 1.1, // Adjusted for stability
                  children: _getTestimonials(),
                ),
        ],
      ),
    );
  }

  List<Widget> _getTestimonials() {
    return const [
      TestimonialCard(
        name: 'Jarreson Davis',
        designation: 'CEO, Luxe Fashion',
        rating: 5,
        text:
            'Abdur delivered our WooCommerce solution ahead of schedule. The quality of work and attention to detail was exceptional. Highly recommended!',
        initials: 'JD',
      ),
      TestimonialCard(
        name: 'Anika Khatun',
        designation: 'Founder, FitTech',
        rating: 5,
        text:
            'The Flutter implementation was impressive. Our mobile app works perfectly on both iOS and Android with a very smooth UI.',
        initials: 'AK',
      ),
      TestimonialCard(
        name: 'Marcos Reynaldo',
        designation: 'Product Manager, EduCare',
        rating: 5,
        text:
            'We hired Abdur to manage our client onboarding system. The custom API integration is seamless and extremely reliable.',
        initials: 'MR',
      ),
    ];
  }
}

class TestimonialCard extends StatelessWidget {
  final String name;
  final String designation;
  final int rating;
  final String text;
  final String initials;

  const TestimonialCard({
    super.key,
    required this.name,
    required this.designation,
    required this.rating,
    required this.text,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      margin: isMobile ? const EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppTheme.cardBgSecondary,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          top: BorderSide(color: AppTheme.primaryAccent.withOpacity(0.8), width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              rating,
              (index) => const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            '"$text"',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppTheme.primaryAccent.withOpacity(0.2),
                child: Text(
                  initials,
                  style: const TextStyle(
                      color: AppTheme.primaryAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    Text(
                      designation,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }
}
