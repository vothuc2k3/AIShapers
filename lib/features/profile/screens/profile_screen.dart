import 'package:ai_shapers/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh đại diện
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150',
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
        ],
      ),
    );
  }
}
