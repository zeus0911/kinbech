import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kinbech/seller/product%20input/productinfo.dart';
import 'package:kinbech/seller/product%20input/edit_product.dart';

class ManageOrdersScreen extends StatefulWidget {
  @override
  _ManageOrdersScreenState createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Orders'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Products')
            .where('userId', isEqualTo: _auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProductScreen()),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Product'),
                  ),
                  Text('No products found'),
                ],
              ),
            );
          }
          return Column(
            children: [
              if (snapshot.hasError)
                Text('Error: ${snapshot.error}')
              else if (snapshot.connectionState == ConnectionState.waiting)
                CircularProgressIndicator()
              else
                Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data!.docs[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return ProductDetailPage(
                                image: doc['Image'],
                                title: doc['Title'],
                                description: doc['Description'],
                                price: doc['Price'],
                                features: doc['Features'].cast<String>(),
                                latitude: doc['Latitude'],
                                longitude: doc['Longitude'],
                              );
                            }));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            height: 200, // Set the desired height for the tile
                            child: Card(
                              elevation: 4, // Add elevation for shadow effect
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0), // Set rounded corners
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        bottomLeft: Radius.circular(12.0),
                                      ),
                                      child: Image.network(
                                        doc['Image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doc['Title'],
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            doc['Description'],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Spacer(),
                                          Text(
                                            'Price/hr: \$${doc['Price']}',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductScreen()),
                  );
                },
                icon: Icon(Icons.add),
                label: Text('Add Product'),
              ),
            ],
          );
        },
      ),
    );
  }
}
