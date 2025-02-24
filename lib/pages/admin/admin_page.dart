import 'package:find_pe/app/router.dart';
import 'package:find_pe/common/style/app_colors.dart';
import 'package:find_pe/common/style/app_style.dart';
import 'package:find_pe/pages/admin/admin_dashboard.dart';
import 'package:find_pe/pages/admin/admin_home.dart';
import 'package:find_pe/pages/admin/admin_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AdminHomePage(),
    AdminSearchPage(),
    AdminDashboardPage(),
  
  ];

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      context.go(Routes.firebaseStreem);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ui,
      appBar: AppBar(
        backgroundColor: AppColors.grade1,
        centerTitle: true,
        title: Text(
          'Admin Page',
          style: AppStyle.fontStyle.copyWith(
            color: AppColors.backgroundColor,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: logout,
            icon: CircleAvatar(
              backgroundColor: AppColors.backgroundColor,
              radius: 18,
              child: Icon(Icons.logout, color: AppColors.grade1),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        selectedItemColor: AppColors.grade1,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Admin Home',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Seerching',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        context.push(Routes.adminAdding);
      }),
    );
  }
}
