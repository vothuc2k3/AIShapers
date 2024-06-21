import 'package:ai_shapers/core/constants/error_text.dart';
import 'package:ai_shapers/core/constants/loading.dart';
import 'package:ai_shapers/features/auth/controller/auth_controller.dart';
import 'package:ai_shapers/features/auth/repository/auth_repository.dart';
import 'package:ai_shapers/features/home/screens/home_screen.dart';
import 'package:ai_shapers/firebase_options.dart';
import 'package:ai_shapers/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userData;

  Future<void> _getUserData(WidgetRef ref, User data) async {
    userData = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userData);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStageChangeProvider).when(
          data: (user) {
            if (user != null) {
              _getUserData(ref, user);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'AI Shapers',
                home: Consumer(
                  builder: (context, watch, child) {
                    final userData = ref.watch(userProvider);
                    if (userData != null) {
                      return const HomeScreen();
                    } else {
                      return const Loading();
                    }
                  },
                ),
              );
            } else {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'AI Shapers',
                home: HomeScreen(), //change here
              );
            }
          },
          error: (error, stackTrace) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AI Shapers',
            home: ErrorText(error: error.toString()),
          ),
          loading: () => const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AI Shapers',
            home: Loading(),
          ),
        );
  }
}
