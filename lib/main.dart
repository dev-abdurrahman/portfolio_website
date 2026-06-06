import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/navbar.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/services_section.dart';
import 'widgets/portfolio_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer.dart';
import 'pages/my_apps_page.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdur Rahman | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      scrollBehavior: MyCustomScrollBehavior(),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50) {
        if (!_isScrolled) setState(() => _isScrolled = true);
      } else {
        if (_isScrolled) setState(() => _isScrolled = false);
      }
    });
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      endDrawer: isMobile ? _buildDrawer() : null,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure sections fill width
                children: [
                  HeroSection(key: _homeKey),
                  AboutSection(key: _aboutKey),
                  ServicesSection(key: _servicesKey),
                  PortfolioSection(key: _workKey),
                  ContactSection(key: _contactKey),
                  const Footer(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              isScrolled: _isScrolled,
              onNavTap: (index) {
                if (index == 0) _scrollToSection(_homeKey);
                if (index == 1) _scrollToSection(_aboutKey);
                if (index == 2) _scrollToSection(_servicesKey);
                if (index == 3) _scrollToSection(_workKey);
                if (index == 4) _scrollToSection(_contactKey);
                if (index == 5) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyAppsPage()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppTheme.bgColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.cardBg),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Abdur Rahman',
                    style: AppTheme.headingStyle.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  const Text('Developer Portfolio', style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
                ],
              ),
            ),
          ),
          _drawerItem('Home', 0, Icons.home_outlined),
          _drawerItem('About', 1, Icons.person_outline),
          _drawerItem('Services', 2, Icons.work_outline),
          _drawerItem('Work', 3, Icons.palette_outlined),
          _drawerItem('My Apps', 5, Icons.shop_two_outlined),
        ],
      ),
    );
  }

  Widget _drawerItem(String title, int index, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryAccent, size: 20),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        if (index == 0) _scrollToSection(_homeKey);
        if (index == 1) _scrollToSection(_aboutKey);
        if (index == 2) _scrollToSection(_servicesKey);
        if (index == 3) _scrollToSection(_workKey);
        if (index == 4) _scrollToSection(_contactKey);
        if (index == 5) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyAppsPage()),
          );
        }
      },
    );
  }
}
