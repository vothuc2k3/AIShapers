import 'package:ai_shapers/features/chat/screens/chat_screen.dart';
import 'package:ai_shapers/features/search/delegate/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchLawDelegate(ref),
                );
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 217, 217, 217),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Tư Vấn Pháp Luật cho Trẻ em',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color:
                              Color.fromARGB(64, 0, 0, 0), // 25% opacity black
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 7, 12, 29),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    'Xin chào, Dustin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text(
                'Chào mừng đến với ứng dụng! Bắt đầu đoạn chat với tôi hoặc tìm kiếm các điều khoản luật!',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Chat với Tư vấn viên AI ngay',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CustomDiamondIcon(),
                    title: const Text(
                      'Chat text 1 passage .....',
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Raleway'),
                    ),
                    trailing: const Icon(Icons.close, color: Colors.white),
                    onTap: () {
                      // Handle chat item tap
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 13, 24, 61),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Tìm kiếm',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Chat screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: const Icon(
          Icons.edit,
          size: 30,
          color: Color.fromARGB(
              255, 0, 0, 0), // Ensure the icon color matches the design
        ),
      ),
    );
  }
}

class CustomDiamondIcon extends StatelessWidget {
  const CustomDiamondIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: DiamondPainter(),
      ),
    );
  }
}

class DiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(
          255, 50, 60, 80) // Update color to match the design
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
