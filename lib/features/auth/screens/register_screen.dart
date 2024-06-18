import 'package:ai_shapers/features/auth/screens/login_screen.dart';
import 'package:ai_shapers/features/auth/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
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
          padding: const EdgeInsets.symmetric(vertical: 20),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child:
                    RegisterForm(), // Assuming this widget is defined and does not exceed screen height
              ),
              // Footer
              Container(
                margin: const EdgeInsets.only(
                    bottom: 20), // Add margin at the bottom
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Display inline row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            // Navigate to sign up screen
                            // Example navigation:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
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
