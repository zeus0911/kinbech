import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String firstName = ''; // New variable to store the user's first name

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

  // New function to fetch user details and update the UI
  void fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Map<String, dynamic> userDetails = await getUserDetails(user.email!);

      // Assuming 'first name' is the field name in Firestore
      setState(() {
        firstName = userDetails['first name'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$firstName",
          style: GoogleFonts.getFont("DM Sans",
              textStyle: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 28)),
        ),
      ),
    );
  }
}

