import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppsPage extends StatefulWidget {
  const MyAppsPage({super.key});

  @override
  State<MyAppsPage> createState() => _MyAppsPageState();
}

class _MyAppsPageState extends State<MyAppsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = ['For you', 'Top charts', 'Categories', 'Editors\' Choice'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProjects = projects.where((p) => p.type == ProjectType.app).toList();
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        backgroundColor: AppTheme.bgColor,
        elevation: 0,
        toolbarHeight: 80,
        title: Container(
          height: 45,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.cardBgSecondary,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white10),
          ),
          child: const TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Search apps & games',
              hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
              prefixIcon: Icon(Icons.search, color: Colors.white38),
              suffixIcon: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppTheme.primaryAccent,
                  radius: 12,
                  child: Text('A', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppTheme.primaryAccent,
          indicatorWeight: 3,
          labelColor: AppTheme.primaryAccent,
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          tabs: _categories.map((cat) => Tab(text: cat)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildForYouSection(appProjects, isMobile),
          const Center(child: Text('Top Charts Coming Soon', style: TextStyle(color: AppTheme.textMuted))),
          const Center(child: Text('Categories Coming Soon', style: TextStyle(color: AppTheme.textMuted))),
          const Center(child: Text('Editors\' Choice Coming Soon', style: TextStyle(color: AppTheme.textMuted))),
        ],
      ),
      bottomNavigationBar: isMobile ? _buildBottomNavBar() : null,
    );
  }

  Widget _buildForYouSection(List<ProjectModel> apps, bool isMobile) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Suggested for you'),
          const SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: apps.length,
              itemBuilder: (context, index) => _buildLargeAppCard(apps[index]),
            ),
          ),
          const SizedBox(height: 40),
          _sectionHeader('Recently updated'),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 80,
            ),
            itemCount: apps.length,
            itemBuilder: (context, index) => _buildSmallAppTile(apps[index]),
          ),
          const SizedBox(height: 40),
          _sectionHeader('Featured Developer: Abdur Rahman'),
          const SizedBox(height: 20),
          _buildFeaturedBanner(),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const Icon(Icons.arrow_forward, color: Colors.white60, size: 20),
      ],
    );
  }

  Widget _buildLargeAppCard(ProjectModel app) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              gradient: app.iconPath == null ? LinearGradient(colors: app.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
              color: app.iconPath != null ? Colors.transparent : null,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: app.iconPath != null 
                ? Image.asset(app.iconPath!, fit: BoxFit.cover)
                : const Icon(Icons.shop_two_rounded, color: Colors.white, size: 60),
            ),
          ),
          const SizedBox(height: 12),
          Text(app.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
          Text(app.tag.split(',')[0], style: const TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSmallAppTile(ProjectModel app) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              gradient: app.iconPath == null ? LinearGradient(colors: app.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight) : null,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: app.iconPath != null
                ? Image.asset(app.iconPath!, fit: BoxFit.cover)
                : const Icon(Icons.shop_two_rounded, color: Colors.white, size: 30),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(app.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const Text('Abdur Rahman', style: TextStyle(color: Colors.white38, fontSize: 12)),
                const Text('4.8 ★ 12MB', style: TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          _installButton(app),
        ],
      ),
    );
  }

  Widget _installButton(ProjectModel app) {
    return ElevatedButton(
      onPressed: () => app.apkUrl != null ? _launchUrl(app.apkUrl!) : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.05),
        foregroundColor: AppTheme.primaryAccent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.white10)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        minimumSize: const Size(0, 32),
      ),
      child: const Text('Install', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildFeaturedBanner() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/about-photo.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.9), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Flutter Portfolio Apps', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Handcrafted with love by Abdur Rahman', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomNavItem(Icons.games_outlined, 'Games', false),
          _bottomNavItem(Icons.apps, 'Apps', true),
          _bottomNavItem(Icons.local_offer_outlined, 'Offers', false),
          _bottomNavItem(Icons.book_outlined, 'Books', false),
        ],
      ),
    );
  }

  Widget _bottomNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? AppTheme.primaryAccent : Colors.white60, size: 24),
        Text(label, style: TextStyle(color: isActive ? AppTheme.primaryAccent : Colors.white60, fontSize: 10)),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
