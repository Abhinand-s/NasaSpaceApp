import 'package:flutter/material.dart';

class RoutePage extends StatelessWidget {
  final String method;

  RoutePage({required this.method});

  @override
  Widget build(BuildContext context) {
    String route;
    String imageAsset;

    // Define routes and images based on the selected shipping method
    switch (method) {
      case 'Air':
        route = 'Route: Airport ➔ Customs ➔ Destination Country Airport';
        imageAsset = 'assets/air.jpg'; // Path to air route image
        break;
      case 'Sea':
        route = 'Route: Port ➔ Customs ➔ Destination Country Port';
        imageAsset = 'assets/sea.webp'; // Path to sea route image
        break;
      case 'Land':
        route = 'Route: Departure City ➔ Customs ➔ Destination City';
        imageAsset = 'assets/land.png'; // Path to land route image
        break;
      default:
        route = 'No route available';
        imageAsset = '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Shipment Route'),
        backgroundColor: Colors.blue[800], // Set the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display the route information
            Text(
              route,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            // Display the associated image if available
            if (imageAsset.isNotEmpty)
              Image.asset(
                imageAsset,
                height: 200, // Adjust the height as needed
              ),
          ],
        ),
      ),
    );
  }
}
