import 'package:flutter/material.dart';
import 'package:adminmetrogenius/admin/bottom_nav_admin/profile/profile.dart';
import 'package:adminmetrogenius/utils/constants.dart';
import 'package:adminmetrogenius/admin/bottom_nav_admin/Home/home_admin.dart';
import 'package:adminmetrogenius/admin/bottom_nav_admin/category/main/add_category_admin.dart';
import 'package:adminmetrogenius/admin/bottom_nav_admin/employe_List/admin_employe_list.dart';


class AdminBottomNavigation extends StatefulWidget {
  const AdminBottomNavigation({super.key});

  @override
  State<AdminBottomNavigation> createState() => _AdminBottomNavigation();
}

class _AdminBottomNavigation extends State<AdminBottomNavigation> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> screens = [
    const AdminHome(),
    const AddCategoryAdmin(),
    const EmployeeListAdmin(),
    const Profile(),
  ];

  void setPage(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600; // Adjust width as needed

    return Scaffold(
      key: _scaffoldKey,
      appBar: isWideScreen ? null : AppBar(
        title: Text('MetroGenius'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: isWideScreen ? null : _buildDrawer(),
      body: Row(
        children: [
          if (isWideScreen)
            Container(
              width: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(35, 74, 203, 1),
                    Color.fromRGBO(28, 36, 52, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: PersistentDrawer(
                onMenuItemSelected: setPage,
                currentIndex: currentIndex,
              ),
            ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: screens,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(35, 74, 203, 1),
              Color.fromRGBO(28, 36, 52, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: PersistentDrawer(
          onMenuItemSelected: setPage,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}

class PersistentDrawer extends StatefulWidget {
  final Function(int) onMenuItemSelected;
  final int currentIndex;

  PersistentDrawer({required this.onMenuItemSelected, required this.currentIndex});

  @override
  _PersistentDrawerState createState() => _PersistentDrawerState();
}

class _PersistentDrawerState extends State<PersistentDrawer> {
  int? _hoveredIndex;

  final Color _hoverColor = Color.fromRGBO(35, 74, 203, 0.8);
  final Color _selectedColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 80,
            child: Center(
              child: Text(
                'MetroGenius',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          AppConstants.kheight20,
          _buildListTile(0, '  Home', Icon(Icons.explore)),
          AppConstants.kheight10,
          _buildListTile(1, '  Category', Icon(Icons.category)),
          AppConstants.kheight10,
          _buildListTile(2, '  Employees', Icon(Icons.person_2)),
          AppConstants.kheight10,
          _buildListTile(3, '  Profile', Icon(Icons.document_scanner)),
          AppConstants.kheight10,
          _buildListTile(4, '  Settings', Icon(Icons.settings)),
        ],
      ),
    );
  }

  Widget _buildListTile(int index, String title, Icon icon) {
    final isSelected = widget.currentIndex == index;
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => _onHover(index, true),
      onExit: (_) => _onHover(index, false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected || isHovered ? _hoverColor : _selectedColor,
          border: Border.all(
            color: isSelected || isHovered ? _hoverColor : Colors.transparent,
            width: 1.0,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => widget.onMenuItemSelected(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    icon.icon,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                selected: isSelected,
                selectedTileColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(int index, bool isHovering) {
    setState(() {
      _hoveredIndex = isHovering ? index : null;
    });
  }
}
