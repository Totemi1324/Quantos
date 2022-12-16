import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../home/home_screen.dart';
import '../home/profile_screen.dart';
import '../settings_screen.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _pages = List<Widget>.empty();
  int _selectedPageIndex = 2;
  late ImageProvider _image;

  @override
  void initState() {
    _pages = [
      Container(),
      Container(),
      const HomeScreen(),
      Container(),
      const ProfileScreen(),
    ];
    _image = const AssetImage("assets/images/background.png");
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
          items: [
            _buildNavbarIcon(Icons.download_rounded),
            _buildNavbarIcon(Icons.code_rounded),
            _buildNavbarIcon(Icons.home_rounded),
            _buildNavbarIcon(Icons.stacked_bar_chart_rounded),
            _buildNavbarIcon(Icons.person_rounded),
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
