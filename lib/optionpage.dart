import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinbech/seller/homepage.dart';


class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  bool isSellerSelected = false;
  bool isConsumerSelected = false;
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
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(children: [
                  const SizedBox(
                    height: 90,
                  ),
                  Icon(Icons.car_rental_rounded,size: size.width*0.2, 
                                color: Colors.amber,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("Parkme",
                            style: GoogleFonts.getFont("DM Sans",
                                textStyle: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35))),
                      ),
                      Center(
                        child: Text(" Daddy",
                            style: GoogleFonts.getFont("DM Sans",
                                textStyle: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 35))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("Welcome, ",
                            style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20))
                      ),
                      Center(
                        child: Text("$firstName",
                            style: GoogleFonts.getFont("DM Sans",
                                textStyle: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text("Select a  Service",
                        style: GoogleFonts.getFont("DM Sans",
                            textStyle: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 18))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSellerSelected = !isSellerSelected;
                        isConsumerSelected = false;
                      });
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100),
                        height: size.height * 0.1,
                        width: size.width * 0.8,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.home),
                            const SizedBox(width: 20),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Rent your space',
                                style: GoogleFonts.getFont("DM Sans",
                                    textStyle: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18))),
                            const Spacer(), // Added spacer for the checkbox
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              value: isSellerSelected,
                              onChanged: (value) {
                                setState(() {
                                  isSellerSelected = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isConsumerSelected = !isConsumerSelected;
                        isSellerSelected = false;
                      });
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100),
                        height: size.height * 0.1,
                        width: size.width * 0.8,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.car_rental),
                            const SizedBox(width: 20),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Find places to park',
                                style: GoogleFonts.getFont("DM Sans",
                                    textStyle: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18))),
                            const Spacer(), // Added spacer for the checkbox
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              value: isConsumerSelected,
                              onChanged: (value) {
                                setState(() {
                                  isConsumerSelected = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isSellerSelected) {
Navigator.of(context).push(MaterialPageRoute(builder: (context){
  return HomePage(isSellerMode: true,);
}));
                      } else if (isConsumerSelected) {

                      }
                    },
                    child: Container(
                      width: size.width * 0.8,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ]))));
  }
}
