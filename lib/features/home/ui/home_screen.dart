import 'package:flutter/material.dart';

import '../../../core/widgets/salomon_bottom_bar.dart';
import 'widgets/home_widget.dart';
import 'widgets/profile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeWidget(),
      const Center(child: Text("Screen 2")),
      const Center(child: Text("Screen 3")),
      ProfileWidget(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: CustomSalomonBottomBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
