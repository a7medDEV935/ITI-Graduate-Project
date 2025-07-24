import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class CustomSlidingNavbar extends StatelessWidget {
  const CustomSlidingNavbar(
      {super.key, required this.selectedIndex, required this.onTabChange});
  final int selectedIndex;
  final void Function(int) onTabChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SlidingClippedNavBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          onButtonPressed: onTabChange,
          fontSize: 14,
          activeColor: Theme.of(context).colorScheme.primary,
          selectedIndex: selectedIndex,
          barItems: [
            BarItem(
              icon: Icons.home,
              title: "Home",
            ),
            BarItem(
              icon: Icons.receipt_long,
              title: "Orders",
            ),
            BarItem(
              icon: Icons.shopping_cart,
              title: "Cart",
            ),
            BarItem(
              icon: Icons.person,
              title: "profile",
            ),
          ],
        ),
      ),
    );
  }
}
