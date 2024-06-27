import 'package:ai_shapers/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Tư vấn luật Trẻ Em AI',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Body
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child:
                    LoginForm(), // Assuming this widget is defined and does not exceed screen height
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
                        const Text('Không có tài khoản?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Đăng ký',
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
