import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle login logic
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Color.fromARGB(255, 205, 203, 203); // Màu xám khi hover
                          }
                          return Colors.blue; // Màu xanh dương mặc định
                        },
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Màu chữ đen
                    ),
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
