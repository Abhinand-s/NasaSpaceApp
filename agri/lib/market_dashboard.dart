import 'package:flutter/material.dart';

class MarketDashboard extends StatefulWidget {
  @override
  _MarketDashboardState createState() => _MarketDashboardState();
}

class _MarketDashboardState extends State<MarketDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Dashboard'),
        backgroundColor: Colors.green[800], // Dark green for the agriculture theme
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/background.jpg'), // Add relevant background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.green.withOpacity(0.2), BlendMode.darken),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Market Prices Section
            Text(
              'Crop Prices',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green[900], // Dark green text
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildDashboardCard(context, 'Wheat', '₹2200 / quintal', Icons.grain),
                  _buildDashboardCard(context, 'Rice', '₹1800 / quintal', Icons.rice_bowl),
                  _buildDashboardCard(context, 'Corn', '₹1500 / quintal', Icons.park),
                  _buildDashboardCard(context, 'Tomato', '₹30 / kg', Icons.local_florist),
                  _buildDashboardCard(context, 'Potato', '₹25 / kg', Icons.local_florist),
                  _buildDashboardCard(context, 'Soybean', '₹4000 / quintal', Icons.grass),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Market Trends Section
            // Text(
            //   'Market Trends',
            //   style: TextStyle(
            //     fontSize: 22,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.green[900],
            //   ),
            // ),
            // const SizedBox(height: 10),
            // Expanded(
            //   child: ListView(
            //     children: [
            //       _buildTrendTile(context, 'Wheat Demand on Rise', Icons.trending_up),
            //       _buildTrendTile(context, 'Decrease in Rice Prices', Icons.trending_down),
            //       _buildTrendTile(context, 'High Supply of Corn', Icons.agriculture),
            //       _buildTrendTile(context, 'Tomato Prices Expected to Rise', Icons.price_change),
            //       _buildTrendTile(context, 'Soybean Prices Fluctuating', Icons.trending_flat),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Function to build cards for different crops and prices, now with navigation
  Widget _buildDashboardCard(BuildContext context, String cropName, String price, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CropDetailPage(cropName: cropName, price: price),
          ),
        );
      },
      child: Card(
        color: Colors.green[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.green[800]),
              const SizedBox(height: 10),
              Text(
                cropName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(price, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build market trend tiles, now with navigation
  Widget _buildTrendTile(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, size: 30, color: Colors.green[800]),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrendDetailPage(trendTitle: title),
          ),
        );
      },
    );
  }
}

// Crop Detail Page
class CropDetailPage extends StatelessWidget {
  final String cropName;
  final String price;

  CropDetailPage({required this.cropName, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$cropName Details'),
        backgroundColor: Colors.green[800],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Update the path to your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView( // Allow scrolling if content overflows
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cropName,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Current Price: $price',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                // Market Trends Section
                _buildSectionTitle('Market Trends'),
                _buildSectionContent(
                  'The market for $cropName is currently influenced by various factors including seasonality, demand-supply dynamics, and climatic conditions. Prices are expected to fluctuate based on these elements.',
                ),
                const SizedBox(height: 20),
                // Growth Conditions Section
                _buildSectionTitle('Growth Conditions'),
                _buildSectionContent(
                  'Optimal conditions for growing $cropName include well-drained soil, adequate sunlight, and proper irrigation. The ideal temperature range for growth is between 20°C to 30°C.',
                ),
                const SizedBox(height: 20),
                // Tips Section
                _buildSectionTitle('Tips for Cultivation'),
                _buildSectionContent(
                  '1. Use organic fertilizers for better yield.\n'
                  '2. Regularly check for pests and diseases.\n'
                  '3. Ensure consistent watering, especially during dry spells.',
                ),
                const SizedBox(height: 20),
                // Additional Info Section
                _buildSectionTitle('Additional Information'),
                _buildSectionContent(
                  'Harvesting should be done when the crops reach full maturity. Proper storage conditions should be maintained to maximize shelf life and quality.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green[800],
      ),
    );
  }

  // Helper method to build section content
  Widget _buildSectionContent(String content) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // Semi-transparent white background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}


// Trend Detail Page
class TrendDetailPage extends StatelessWidget {
  final String trendTitle;

  TrendDetailPage({required this.trendTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$trendTitle Details'),
        backgroundColor: Colors.green[800],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background1.jpg'), // Update the path to your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trendTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Description: \nThis is detailed information about the market trend: $trendTitle. It includes the factors affecting this trend and the potential impact on future prices.',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MarketDashboard(),
  ));
}
