import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:miniproject/Screen/Home/home.dart';
import 'package:miniproject/Screen/Search/search_page.dart';
import 'package:miniproject/Screen/Bookmark/bookmark_screen.dart';

class BottomnavPage extends StatefulWidget {
  const BottomnavPage({super.key});

  @override
  State<BottomnavPage> createState() => _BottomnavPageState();
}

class _BottomnavPageState extends State<BottomnavPage> {
  int _selectedIndex = 0;
  List pages = [
    const HomePage(),
    const SearchScreen(),
    const BookmarkScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(),
      body: pages[_selectedIndex],
    );
  }

  Widget bottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 10,
        ),
        child: GNav(
          backgroundColor: Colors.white,
          color: Colors.grey,
          activeColor: Colors.green,
          tabBackgroundColor: const Color(0xffDEF5E5),
          gap: 8,
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            if (mounted) {
              if (_selectedIndex != index) {
                setState(() {
                  _selectedIndex = index;
                });
              }
            }
          },
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.bookmark,
              text: 'Bookmarks',
            ),
          ],
        ),
      ),
    );
  }
}
