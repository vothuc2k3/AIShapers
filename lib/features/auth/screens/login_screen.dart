import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents the screen from resizing when keyboard appears
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context)
              .size
              .height, // Ensures the container takes full height
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Column(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'AI Shaper',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              // Body
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child:
                    LoginForm(), // Assuming this widget is defined and does not exceed screen height
              ),
              // Footer
              Container(
                margin: EdgeInsets.only(bottom: 20), // Add margin at the bottom
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Display inline row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            // Navigate to sign up screen
                            // Example navigation:
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                          },
                          child: const Text('Sign up',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              )),
                        ),
                      ],
                    ),
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
