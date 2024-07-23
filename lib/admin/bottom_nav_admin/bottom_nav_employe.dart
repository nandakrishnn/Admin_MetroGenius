import 'package:adminmetrogenius/admin/bottom_nav_admin/Home/home_admin.dart';
import 'package:adminmetrogenius/admin/bottom_nav_admin/category/add_category_admin.dart';
import 'package:adminmetrogenius/admin/bottom_nav_admin/employe_List/admin_employe_list.dart';
import 'package:adminmetrogenius/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class AdminBottomNavigation extends StatefulWidget {
  const AdminBottomNavigation({super.key});

  @override
  State<AdminBottomNavigation> createState() => _AdminBottomNavigation();
}

class _AdminBottomNavigation extends State<AdminBottomNavigation> {
  int currentIndex = 0;
  bool isBottomNavVisible = true;

  final PageController _pageController = PageController();

  final List<Widget> screens = [
    AdminHome(),
    AddCategoryAdmin(),
    EmployeeListAdmin(),
  ];

  void setPage(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: screens.map((screen) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is UserScrollNotification) {
                setState(() {
                  if (notification.direction == ScrollDirection.reverse) {
                    isBottomNavVisible = false;
                  } else if (notification.direction == ScrollDirection.forward) {
                    isBottomNavVisible = true;
                  }
                });
              }
              return true;
            },
            child: screen,
          );
        }).toList(),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isBottomNavVisible ? kBottomNavigationBarHeight + 13 : 0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 9, right: 9),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(149, 78, 73, 73),
                  offset: Offset(0, 0),
                  spreadRadius: 2,
                  blurRadius: 5,
                )
              ],
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(35),
            ),
            child: GNav(
              haptic: true,
              color: AppColors.mainBlueColor,
              activeColor: Colors.white,
              gap: 8,
              onTabChange: setPage,
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(color: Colors.white),
              tabBackgroundColor: AppColors.mainBlueColor,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.category,
                  text: 'Category',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Employes',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
