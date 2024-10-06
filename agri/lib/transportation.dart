import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'RoutePage.dart'; // Import the new RoutePage

class ExportPage extends StatefulWidget {
  @override
  _ExportPageState createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  String selectedVegetable = 'Tomato';
  String selectedCountry = 'USA';
  String shippingMethod = 'Air';
  String selectedBuyer = 'Tomato King';
  double quantity = 0.0;
  double estimatedCost = 0.0;
  File? selectedFile;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  // Buyers list for each vegetable
  final Map<String, List<String>> buyersForVegetables = {
    'Tomato': ['Tomato King', 'Fresh Tomatoes Inc.', 'Tomato Traders LLC'],
    'Bell Pepper': ['Pepper Farms', 'Organic Bell Pepper', 'GreenPep Traders'],
    'Green Chili': ['Chili World', 'Green Chili Exporters', 'Spice Heaven Co.'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ship Vegetables Internationally'),
        backgroundColor: Colors.blue[800], // Changed to transportation theme color
      ),
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage('assets/back.jpg'), // Updated background image path
          //   fit: BoxFit.cover,
          // ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Vegetable selection
              Text('Select Vegetable:', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: selectedVegetable,
                onChanged: (newValue) {
                  setState(() {
                    selectedVegetable = newValue!;
                    selectedBuyer = buyersForVegetables[selectedVegetable]![0];
                  });
                },
                items: <String>['Tomato', 'Bell Pepper', 'Green Chili']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.blue[50], // Updated to match transportation theme
                ),
              ),
              SizedBox(height: 20),

              // Quantity input
              Text('Enter Quantity (in Kg):', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    quantity = double.tryParse(value) ?? 0.0;
                    estimatedCost = calculateCost(quantity, shippingMethod);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter quantity in Kg',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              SizedBox(height: 20),

              // Country selection
              Text('Select Destination Country:', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: selectedCountry,
                onChanged: (newValue) {
                  setState(() {
                    selectedCountry = newValue!;
                  });
                },
                items: <String>['USA', 'Canada', 'Germany', 'Australia']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              SizedBox(height: 20),

              // Shipping method selection
              Text('Select Shipping Method:', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: shippingMethod,
                onChanged: (newValue) {
                  setState(() {
                    shippingMethod = newValue!;
                    estimatedCost = calculateCost(quantity, shippingMethod);
                  });
                },
                items: <String>['Air', 'Sea', 'Land']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              SizedBox(height: 20),

              // Buyer selection based on vegetable
              Text('Select Buyer:', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: selectedBuyer,
                onChanged: (newValue) {
                  setState(() {
                    selectedBuyer = newValue!;
                  });
                },
                items: buyersForVegetables[selectedVegetable]!
                    .map<DropdownMenuItem<String>>((String buyer) {
                  return DropdownMenuItem<String>(
                    value: buyer,
                    child: Text(buyer),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
              ),
              SizedBox(height: 20),

              // Estimated cost display
              Text(
                'Estimated Cost: \$${estimatedCost.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
              ),
              SizedBox(height: 20),

              // Document upload
              Text('Upload Export Documents:', style: TextStyle(fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      selectedFile = File(result.files.single.path!);
                    });
                  }
                },
                child: Text(selectedFile == null ? 'Upload Documents' : 'Document Uploaded'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              ),
              if (selectedFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(selectedFile!.path.split('/').last, style: TextStyle(color: Colors.green)),
                ),
              SizedBox(height: 20),

              // Submit button
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          Future.delayed(Duration(seconds: 2), () {
                            setState(() {
                              isLoading = false;
                            });
                            // Navigate to the RoutePage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RoutePage(method: shippingMethod),
                              ),
                            );
                          });
                        }
                      },
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateCost(double quantity, String method) {
    double baseRate = 5.0; // Base rate per Kg
    double shippingCost = 0.0;

    switch (method) {
      case 'Air':
        shippingCost = baseRate * quantity * 2; // Higher cost for air shipping
        break;
      case 'Sea':
        shippingCost = baseRate * quantity; // Standard cost for sea shipping
        break;
      case 'Land':
        shippingCost = baseRate * quantity * 1.5; // Moderate cost for land shipping
        break;
      default:
        shippingCost = baseRate * quantity;
    }
    return shippingCost;
  }
}
