import 'package:flutter/material.dart';
import 'package:kinbech/seller/homepage%20icons/home.dart';
import 'homepage icons/messages.dart';
import 'homepage icons/orders.dart';
import 'homepage icons/profile.dart';

class HomePage extends StatefulWidget {
  final bool isSellerMode;

  const HomePage({Key? key, required this.isSellerMode}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _selectedIndex = 0; // Index of the currently selected page

  // List of pages corresponding to each index
  List<Widget> _pages = [
    HomeScreen(),
    MessagesScreen(),
    ManageOrdersScreen(),
    ProfileScreen(),
  ];

  // Function to handle item selection in the bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex], // Display the current page
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                size: 30,
                color: _selectedIndex == 0 ? Colors.green : Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message,
                size: 30,
                color: _selectedIndex == 1 ? Colors.green : Colors.black),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
                size: 30,
                color: _selectedIndex == 2 ? Colors.green : Colors.black),
            label: 'Manage Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                size: 30,
                color: _selectedIndex == 3 ? Colors.green : Colors.black),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green, // Set the selected item color
        unselectedItemColor: Colors.black,

      ),
    );
  }
}
