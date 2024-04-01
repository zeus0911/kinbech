import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinbech/auth/mainpage.dart';

class Intropage extends StatelessWidget {
  const Intropage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 130,
              ),
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
              Icon(
                Icons.car_rental_rounded,
                size: size.width * 0.2,
                color: Colors.amber,
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Welcome to",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'A JOURNEY OF....',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'CONNECTIONS',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Our Little Initiative Towards Sustainable Sharing",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            )),
                        child: const Text(
                          "LEARN MORE",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const MainPage();
                      }));
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        )),
                    child: const Text(
                      "GET STARTED",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
