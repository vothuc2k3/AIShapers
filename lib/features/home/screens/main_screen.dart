import 'package:ai_shapers/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            children: [
              Text(
                'Xin chào, ${currentUser == null ? '' : currentUser.name}',
                style: const TextStyle(
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
                  style: TextStyle(color: Colors.white, fontFamily: 'Raleway'),
                ),
                trailing: const Icon(Icons.close, color: Colors.white),
                onTap: () {},
              );
            },
          ),
        ),
      ],
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
