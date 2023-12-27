import 'package:flutter/material.dart';
import 'package:flutter_auth/components/designUI.dart';

class HowItWorksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: perfictBlue,
      appBar: customAppBar(context,'How its work'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'System Architecture',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Divider(),
                    SizedBox(height: 16.0),
                    Text(
                      'Overview:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Our system utilizes a sophisticated architecture to ensure seamless operation and efficient performance.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Divider(),
                    SizedBox(height: 16.0),
                    Text(
                      'Key Components:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '- Central Control Unit: Manages and coordinates all system activities.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '- Automation Module: Controls the water pump and ensures optimal usage.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '- Solar Energy System: Harnesses solar power to drive the system.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                    Divider(),
                    SizedBox(height: 16.0),
                    Text(
                      'Workflow:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '1. Solar panels capture sunlight and convert it into electrical energy.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '2. The Central Control Unit processes data and determines water pump activation.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '3. Automation Module regulates water distribution based on demand.',
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
                      '- Optimal Water Usage: Automation ensures water is distributed efficiently.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '- Renewable Energy: Solar power reduces environmental impact.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
