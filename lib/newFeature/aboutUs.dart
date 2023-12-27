import 'package:flutter/material.dart';

import '../components/designUI.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: perfictBlue,
      appBar: customAppBar(context,"About Us"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  'Welcome to our Automation Water Pump and Solar Cells Project!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Text(
                  'Project Overview:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Our project aims to create a sustainable and efficient water pumping system using automation technology and solar cells. This innovative solution is designed to provide a reliable and eco-friendly water supply.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Text(
                  'Key Features:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '- Automation: The water pump is equipped with automated control, allowing for efficient and optimized water distribution.',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '- Solar Cells: Our system harnesses the power of solar energy to operate the water pump, promoting sustainability and reducing reliance on traditional power sources.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Text(
                  'Benefits:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '- Environmentally Friendly: The use of solar cells contributes to a cleaner and greener environment by minimizing carbon footprint.',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  '- Cost-Efficient: Solar-powered systems offer a cost-effective alternative, reducing energy bills and operational expenses.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
                Text(
                  'Contact Us:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'For more information or inquiries about our Automation Water Pump and Solar Cells Project, please contact us at project@example.com.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
