import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/enum/user.dart';
import '../../../core/widgets/salomon_bottom_bar.dart';
import '../../auth/data/repo/firebase_auth_repo.dart';
import '../logic/notifications/notification_cubit.dart';
import 'widgets/cart_widget.dart';
import 'widgets/dashboard_widget.dart';
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

  final UserType currentUserType = getIt<FirebaseRepo>().userType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeWidget(),
      const OrdersWidget(),
      ...currentUserType == UserType.admin ? [const DashBoardWidget()] : [],
      const CartWidget(),
      const ProfileWidget(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: CustomSalomonBottomBar(
        userType: currentUserType,
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
