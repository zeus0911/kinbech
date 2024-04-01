import 'package:flutter/material.dart';
import 'package:kinbech/auth/authpage.dart';
import 'package:kinbech/auth/login.dart';
import 'package:kinbech/buyer/homepage.dart';
import 'package:kinbech/buyer/profie.dart';
import 'package:kinbech/seller/homepage.dart';
import 'package:kinbech/auth/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSellingMode = true;
  String firstName = '';
  String lastName = '';
  String email = '';

  

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<Map<String, dynamic>> getUserDetails(String email) async {
    var userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      return userQuery.docs.first.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  // Function to fetch user details and update the UI
  void fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Map<String, dynamic> userDetails = await getUserDetails(user.email!);

      setState(() {
        firstName = userDetails['first name'] ?? '';
        lastName = userDetails['last name'] ?? '';
        email = userDetails['email'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Seller Profile Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Display other user details
            Text(
              "$firstName $lastName",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // Display other user details
            Text(
              "$email",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ModeToggle(
              isSellerMode: true,
              onModeChanged: (isSellerMode) {
                // Implement logic to handle mode change, like navigating to a different page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        isSellerMode ? HomePage(isSellerMode: true) : BuyerHomePage(),
                  ),
                );
              },
            ),
            // Add more details as needed
            SizedBox(height: 20),
            MaterialButton(
              color: Colors.orange,
              child: Text("Sign Out"),
              onPressed: () {
Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
              }
            )
          ],
        ),
      ),
    );
  }
}
