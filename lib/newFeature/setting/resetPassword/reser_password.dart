import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/components/designUI.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: perfictBlue,
      appBar: customAppBar(context, 'Password Reset'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email', // Set hint text
                  errorStyle: TextStyle(color: Colors.red), // Set error text color
                  fillColor: Colors.white, // Set background color
                  filled: true,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red), // Set error border color
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red), // Set focused error border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Set focused border color
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _resetPassword();
                  }
                },
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text,
      );
      // Show a success message or navigate to another page.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue, // Set your desired background color
          elevation: 10,
          behavior: SnackBarBehavior.floating, // Set the behavior
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Set border radius
          ),
          content: Text(
            'Password reset email sent. Check your email.',
            style: TextStyle(color: Colors.white), // Set text color
          ),
        ),
      );
    } catch (e) {
      // Show an error message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black45, // Set your desired background color for errors
          elevation: 10,
          behavior: SnackBarBehavior.floating, // Set the behavior
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Set border radius
          ),
          content: Text(
            'Failed to send password reset email.',
            style: TextStyle(color: Colors.white), // Set text color
          ),
        ),
      );
      print(e);
    }
  }}

