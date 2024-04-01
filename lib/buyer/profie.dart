import 'package:flutter/material.dart';
import 'package:kinbech/buyer/homepage.dart';
import 'package:kinbech/seller/homepage.dart';
import 'package:kinbech/seller/homepage%20icons/profile.dart';

class BuyerProfileScreen extends StatelessWidget {
  const BuyerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyer Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Buyer Profile Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ModeToggle(
              isSellerMode: false,
              onModeChanged: (isSellerMode) {
                // Implement logic to handle mode change, like navigating to a different page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => isSellerMode
                        ? HomePage(isSellerMode: true)
                        : BuyerHomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ModeToggle extends StatefulWidget {
  final bool isSellerMode;
  final Function(bool) onModeChanged;

  const ModeToggle({
    required this.isSellerMode,
    required this.onModeChanged,
    Key? key,
  }) : super(key: key);

  @override
  _ModeToggleState createState() => _ModeToggleState();
}

class _ModeToggleState extends State<ModeToggle> {
  late bool isSellerMode;

  @override
  void initState() {
    super.initState();
    isSellerMode = widget.isSellerMode;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Switch to',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Buyer',
              style: TextStyle(
                color: !isSellerMode ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Switch(
              value: isSellerMode,
              onChanged: (value) {
                setState(() {
                  isSellerMode = value;
                });

                // Execute the callback function when the mode is changed
                widget.onModeChanged(isSellerMode);
              },
            ),
            Text(
              'Seller',
              style: TextStyle(
                color: isSellerMode ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
