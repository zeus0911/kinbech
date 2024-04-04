import 'package:flutter/material.dart';
import 'package:kinbech/seller/product%20input/editproducctscreen.dart';

class ProductDetailPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;
  final List<String> features;
  final double latitude;
  final double longitude;

  const ProductDetailPage({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.features,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    description,
                    style: TextStyle(fontSize: 18.0, color: Colors.black87),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Price/hr: \$${price}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Features:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features.map((feature) {
                return Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        feature,
                        style: TextStyle(fontSize: 20.0, color: Colors.black87),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Location:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Latitude: $latitude, Longitude: $longitude',
                style: TextStyle(fontSize: 20.0, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return EditProductScreen(image: image, title: title, description: description, price: price, features: features, latitude: latitude, longitude: longitude);
          }));

          if (result == true) {
            // Reload the product details if changes were saved
            // Fetch updated details from Firestore or use local state
            // and update the corresponding variables (image, title, description, etc.)
          }
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
