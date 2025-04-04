import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final pwConfirmController = TextEditingController();

  String? errorText;

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    pwConfirmController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final id = idController.text.trim();
    final pw = pwController.text.trim();
    final confirm = pwConfirmController.text.trim();

    if (!mounted) return;

    if (id.isEmpty || pw.isEmpty || confirm.isEmpty) {
      setState(() => errorText = "모든 항목을 입력해주세요.");
    } else if (pw != confirm) {
      setState(() => errorText = "암호가 일치하지 않습니다.");
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', id);
      await prefs.setString('user_pw', pw);

      // 자동 로그인 처리
      await context.read<AuthProvider>().login();

      // 홈 화면으로 이동 (기존 화면 스택 제거)
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Widget buildInput({
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/login');
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text("마교가입"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                const Text(
                  "설정한 내용은 언제든지 변경할 수 있습니다.",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white30),
                const SizedBox(height: 20),
                buildInput(hint: "별호", controller: idController),
                const SizedBox(height: 12),
                buildInput(hint: "암호", controller: pwController, obscure: true),
                const SizedBox(height: 12),
                buildInput(
                  hint: "암호 확인",
                  controller: pwConfirmController,
                  obscure: true,
                ),
                if (errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF87),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("마교가입", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
