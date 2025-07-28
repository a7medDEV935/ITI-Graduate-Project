import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../features/home/logic/cart/cart_cubit.dart';
import '../../features/home/logic/cart/cart_state.dart';
import '../../features/home/logic/notifications/notification_cubit.dart';
import '../../features/home/logic/notifications/notification_state.dart';
import '../enum/user.dart';

class CustomSalomonBottomBar extends StatelessWidget {
  const CustomSalomonBottomBar(
      {super.key,
      required this.selectedIndex,
      required this.onTabChange,
      required this.userType});
  final int selectedIndex;
  final void Function(int) onTabChange;
  final UserType userType;



  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SalomonBottomBar(
        key: ValueKey(currentLocale.toString()),
        currentIndex: selectedIndex,
        onTap: onTabChange,
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("home".tr()),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
              int badgeCount = state.notificationBadgeCount;
              return Stack(
                children: [
                  Icon(Icons.shopping_bag),
                  if (badgeCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$badgeCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            }),
            title: Text("orders".tr()),
            selectedColor: Colors.orange,
          ),
          ...userType == UserType.admin
              ? [
                  SalomonBottomBarItem(
                    icon: Icon(Icons.dashboard_customize),
                    title: Text("dashboard".tr()),
                    selectedColor: Colors.red,
                  ),
                ]
              : [],
          SalomonBottomBarItem(
            icon: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                int itemCount = 0;
                if (state is CartLoaded) {
                  itemCount = state.totalItems;
                }

                return Stack(
                  children: [
                    Icon(Icons.shopping_cart),
                    if (itemCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '$itemCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            title: Text("cart".tr()),
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("profile".tr()),
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
