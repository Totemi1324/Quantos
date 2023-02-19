import 'package:flutter/material.dart';
import 'package:flutter_gen/gen/assets.gen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../home/home_screen.dart';
import '../home/profile_screen.dart';
import '../home/statistics_screen.dart';
import '../home/download_screen.dart';
import '../home/coding_screen.dart';
import '../settings_screen.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<CurvedNavigationBarState> _navigationBarKey = GlobalKey();
  List<Widget> _pages = List<Widget>.empty();
  int _selectedPageIndex = 2;
  late ImageProvider _image;

  @override
  void initState() {
    _pages = [
      const DownloadScreen(),
      const CodingScreen(),
      const HomeScreen(),
      const StatisticsScreen(),
      const ProfileScreen(),
    ];
    _image = Assets.images.background.provider();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_image, context);
  }

  Widget _buildNavbarIcon(IconData icon) {
    return Icon(
      icon,
      color: Colors.white,
      size: 35,
    );
  }

  void _onSelectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.6, -0.7),
          radius: 2,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
          stops: const [0.0, 1.0],
        ),
        image: DecorationImage(
          image: _image,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: ModalRoute.of(context)?.canPop == true
              ? IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 40,
                  ),
                )
              : null,
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(SettingsScreen.routeName),
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 5),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.settings_rounded,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _navigationBarKey,
          items: [
            _buildNavbarIcon(Icons.save_alt_rounded),
            _buildNavbarIcon(Icons.code_rounded),
            _buildNavbarIcon(Icons.home_rounded),
            _buildNavbarIcon(Icons.show_chart_rounded),
            _buildNavbarIcon(Icons.person_outline_rounded),
          ],
          index: _selectedPageIndex,
          height: 50,
          backgroundColor: Colors.transparent,
          color: const Color(0xFF004964),
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.decelerate,
          onTap: _onSelectPage,
        ),
        body: _pages[_selectedPageIndex],
      ),
    );
  }
}
