import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../product input/productinfo.dart';

class ManageOrdersScreen extends StatefulWidget {
  @override
  _ManageOrdersScreenState createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    // Fetch products from Firestore when the screen initializes
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      // Query Firestore to fetch products
      QuerySnapshot productsSnapshot = await FirebaseFirestore.instance.collection('products').get();

      // Convert QuerySnapshot to a list of Order objects and update the orders list
      setState(() {
        orders = productsSnapshot.docs.map((doc) {
          return Order(
            title: doc['title'],
            description: doc['description'],
            price: doc['price'],
            category: doc['category'],
            imageUrl: doc['imageUrl'],
          );
        }).toList();
      });
    } catch (e) {
      // Handle any errors that occur during data fetching
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Orders'),
      ),
      body: orders.isEmpty
          ? Center(
        child: ElevatedButton.icon(
          onPressed: () {
            // Navigate to the screen to add a new product
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProductScreen()),
            ).then((_) {
              // Refresh the screen after adding a new product
              fetchProducts();
            });
          },
          icon: Icon(Icons.add),
          label: Text('Add Product'),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(orders[index].title),
                  subtitle: Text(orders[index].description),
                  leading: orders[index].imageUrl != null
                      ? Image.network(
                    orders[index].imageUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.image),
                  // Add more details as needed
                );
              },
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to the screen to add a new product
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductScreen()),
              ).then((_) {
                // Refresh the screen after adding a new product
                fetchProducts();
              });
            },
            icon: Icon(Icons.add),
            label: Text('Add Product'),
          ),
        ],
      ),
    );
  }
}

class Order {
  final String title;
  final String description;
  final double price;
  final String category;
  final String? imageUrl;

  Order({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
  });
}
