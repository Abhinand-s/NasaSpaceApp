//import 'package:agri/agribot.dart';
import 'package:agri/bot/main.dart';
import 'package:agri/consumer.dart';
import 'package:agri/market_dashboard.dart';
import 'package:agri/public/public_page.dart';
import 'package:agri/transportation.dart';
import 'package:agri/weather/weather.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AgriSolution Home',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[800], // Dark green for the AppBar
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Background image for the home screen
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.green.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2, // Two items in a row
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            children: [
              _buildOptionCard(
                context,
                icon: Icons.chat_bubble_outline,
                label: 'Chatbot',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
              _buildOptionCard(
                context,
                icon: Icons.cloud_queue_outlined,
                label: 'Weather',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Weatherpage()),
                  );
                },
              ),
              _buildOptionCard(
                context,
                icon: Icons.shopping_basket_outlined,
                label: 'Market Dashboard',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MarketDashboard()),
                  );
                },
              ),
              
              _buildOptionCard(
                context,
                icon: Icons.public,
                label: 'Agrigram',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PublicProfilePage()),
                  );
                },
              ),
              _buildOptionCard(
                context,
                icon: Icons.high_quality,
                label: 'Quality check',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConsumerPage()),
                  );
                },
              ),
              _buildOptionCard(
                context,
                icon: Icons.emoji_transportation_outlined,
                label: 'Transportation',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExportPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build an option card with an icon and label
  Widget _buildOptionCard(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 50.0,
                color: Colors.green[700], // Icon color for consistency with the theme
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[900], // Darker green for the label text
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
