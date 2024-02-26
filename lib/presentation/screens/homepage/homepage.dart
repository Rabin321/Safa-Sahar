import 'package:finalyear/presentation/screens/adminside/addDustbin/addDustbin.dart';
import 'package:finalyear/presentation/screens/adminside/addstaff/ui/addstaff.dart';
import 'package:finalyear/presentation/screens/adminside/adminNotification/adminNotification.dart';
import 'package:finalyear/presentation/screens/adminside/admindashboard/ui/admindashboard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _navigatorBottomNavBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  //different pages to navigate
  final List<Widget> _children = [
    const AdminDashboard(),
    const AdminAddDustbin(),
    const AdminAddStaff(),
    const AdminNotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF52B788),
          fixedColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: _navigatorBottomNavBar,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.delete_outline,
                size: 30,
              ),
              label: "Dustbin",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: 30,
              ),
              label: "People",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                size: 30,
              ),
              label: "Notifications",
            ),
          ]),
    );
  }
}
