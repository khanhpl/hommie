import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../core/utils/color_constant.dart';

class BottomBarNavigator extends StatefulWidget {
  int selectedIndex = 0;

  bool isBottomNav = true;

  BottomBarNavigator(
      {super.key, required this.selectedIndex, required this.isBottomNav});

  @override
  State<BottomBarNavigator> createState() => _BottomBarNavigatorState(
      selectedIndex: selectedIndex, isBottomNav: isBottomNav);
}

class _BottomBarNavigatorState extends State<BottomBarNavigator> {
  int selectedIndex = 0;
  bool isBottomNav = true;

  _BottomBarNavigatorState(
      {required this.selectedIndex, required this.isBottomNav});

  Widget? pageCaller(index) {
    switch (selectedIndex) {
      case 0:
        return const SizedBox();
      case 1:
        return const SizedBox();
      case 2:
        return const SizedBox();
      case 3:
        return const SizedBox();
      case 4:
        return const SizedBox();

      default:
        return const SizedBox();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageCaller(selectedIndex),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstant.primaryColor,
        onPressed: () {},
        child: InkWell(
          splashColor: ColorConstant.primaryColor,
          onTap: () {},
          child: Center(
            child: Icon(Icons.search),
          ),
        ),
      ),
      bottomNavigationBar: isBottomNav == true
          ? BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  // icon: ImageIcon(
                  //   AssetImage(ImageConstant.),
                  // ),
                  icon: Icon(Icons.home),
                  label: 'Trang chủ',
                ),
                BottomNavigationBarItem(
                  // icon: ImageIcon(
                  //   AssetImage(ImageConstant.icSearch),
                  // ),
                  icon: Icon(Icons.shopping_cart),
                  label: 'Giỏ hàng',
                ),
                BottomNavigationBarItem(
                  label: "Tìn kiếm",
                  icon: Icon(Icons.add),
                ),
                BottomNavigationBarItem(
                  // icon: ImageIcon(
                  //   AssetImage(ImageConstant.icProfile),
                  // ),
                  icon: Icon(Icons.edit_document),
                  label: 'Đơn hàng',
                ),
                BottomNavigationBarItem(
                  // icon: ImageIcon(
                  //   AssetImage(ImageConstant.icProfile),
                  // ),
                  icon: Icon(Icons.person),
                  label: 'Tài khoản',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: ColorConstant.primaryColor,
              selectedLabelStyle: TextStyle(
                color: ColorConstant.primaryColor,
              ),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(
                color: Colors.black,
              ),
              showUnselectedLabels: true,
              elevation: 0,
              onTap: _onItemTapped,
            )
          : Container(
              height: 0,
            ),
    );
  }
}
