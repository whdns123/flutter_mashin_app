import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

// ⚠️ 클래스 이름 충돌 방지: splash_screen.dart에 정의된 SplashScreen만 import
import 'auth/screens/splash_screen.dart';
import 'auth/screens/signup_screen.dart';
import 'auth/screens/home_screen.dart';

// 💡 만약 login_screen.dart에도 SplashScreen이 있다면 다음과 같이 prefix 붙이기
import 'auth/screens/login_screen.dart' as login;

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AuthProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '마교 쇼핑몰',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(), // ✅ splash_screen.dart 기준
        '/login': (context) => const login.LoginScreen(), // ✅ prefix 사용
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
