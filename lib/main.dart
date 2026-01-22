import 'package:flutter/material.dart';
import 'second.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  TextEditingController distanceController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController tipController = TextEditingController();
  
  double baseFare = 0.0;
  double commission = 0.0;

  void calculateEarnings() {
    double distance = double.tryParse(distanceController.text) ?? 0;
    double rate = double.tryParse(rateController.text) ?? 0;
    
    setState(() {
      baseFare = distance * rate;
      commission = baseFare * 0.02;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rider Earnings Estimator'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Container(
              height: 150,
              child: Image.asset(
                'assets/delivery.png',
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.delivery_dining, size: 100, color: Colors.amber);
                },
              ),
            ),
            SizedBox(height: 20),
            
            // Distance Input
            TextField(
              controller: distanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Distance (km)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            
            // Rate Input
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Rate per km',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            
            // Tip Input
            TextField(
              controller: tipController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tip (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            
            // Calculate Button
            ElevatedButton(
              onPressed: calculateEarnings,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.all(15),
              ),
              child: Text(
                'Calculate Earnings',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            
            // Base Fare Display
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Base Fare: Rs ${baseFare.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 15),
            
            // Commission Display
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Platform Commission (2%): Rs ${commission.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            
            // View Final Earnings Button
            ElevatedButton(
              onPressed: () {
                double tip = double.tryParse(tipController.text) ?? 0;
                double finalEarnings = (baseFare - commission) + tip;
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(
                      baseFare: baseFare,
                      commission: commission,
                      tip: tip,
                      finalEarnings: finalEarnings,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 47, 186, 201),
                padding: EdgeInsets.all(15),
              ),
              child: Text(
                'View Final Earnings',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}