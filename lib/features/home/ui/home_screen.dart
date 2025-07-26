import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/salomon_bottom_bar.dart';
import '../logic/notifications/notification_cubit.dart';
import 'widgets/cart_widget.dart';
import 'widgets/home_widget.dart';
import 'widgets/orders_widget.dart';
import 'widgets/profile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeWidget(),
      const OrdersWidget(),
      const CartWidget(),
      const ProfileWidget(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: CustomSalomonBottomBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            context.read<NotificationCubit>().setNotificationScreenOpen(true);
          } else {
            context.read<NotificationCubit>().setNotificationScreenOpen(false);
          }
        },
      ),
    );
  }
}
