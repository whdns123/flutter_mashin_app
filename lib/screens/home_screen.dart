import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_provider.dart';
import 'dart:io';
import '../models/user_profile.dart';

import 'my_page_screen.dart';


class HomeScreen extends StatelessWidget {
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = Provider.of<UserProvider>(context).profiles;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '마왕',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '컬렉션',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: profiles.isEmpty
          ? const Center(
              child: Text(
                '등록된 프로필이 없습니다.',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return Stack(
                  children: [
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white24,
                            backgroundImage: profile.imageUrl.isNotEmpty
                                ? FileImage(File(profile.imageUrl))
                                : null,
                            child: profile.imageUrl.isEmpty
                                ? Text(profile.name[0], style: const TextStyle(color: Colors.black))
                                : null,
                          ),
                          title: Text(profile.name, style: const TextStyle(color: Colors.black)),
                          subtitle: Text(profile.bio, style: const TextStyle(color: Colors.black87)),
                          trailing: Text(profile.role, style: const TextStyle(color: Colors.black)),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('상품 페이지는 현재 준비 중입니다!'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyPageScreen(profileToEdit: profile),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyPageScreen(),
            ),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
