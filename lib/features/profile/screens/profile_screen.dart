import 'package:ai_shapers/features/auth/controller/auth_controller.dart';
import 'package:ai_shapers/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại xác nhận
              },
            ),
            TextButton(
              child: const Text('Đăng xuất'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại xác nhận
                logout(); 
              },
            ),
          ],
        );
      },
    );
  }

  void logout() {
    ref.watch(authControllerProvider.notifier).signOut(ref);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Container(
        color: const Color(0xFF00001c),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh đại diện
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://naitreetgrandir.com/documentsng/images/imagesdossierunepage/our-children-s-emotions/our-children-s-emotions.jpg',
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Tên người dùng
            Center(
              child: Text(
                user!.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Email
            ListTile(
              leading: const Icon(Icons.email, color: Colors.white),
              title: Text(
                user.email,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Divider(color: Colors.white),
            // Số điện thoại
            const ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                '0828001062',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Divider(color: Colors.white),
            // Địa chỉ
            const ListTile(
              leading: Icon(Icons.location_on, color: Colors.white),
              title: Text(
                'Cần Thơ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Divider(color: Colors.white),
            // Nút đăng xuất
            Center(
              child: ElevatedButton(
                onPressed: () => _showLogoutConfirmationDialog(),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: const Text('Đăng xuất'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
