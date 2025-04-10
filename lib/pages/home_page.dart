import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_firebase/pages/library/library_feed.dart';
import 'package:project_firebase/pages/wallpapers/wp_feed.dart';
import 'package:project_firebase/pages/letters/letters_feed.dart';
import 'package:project_firebase/pages/youtube/yt_feed.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.menu, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(
                    "Welcome ${widget.user.email ?? 'User Email'}",
                    style: const TextStyle(
                      color: Color(0xffBE5985),
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.notifications_none, color: Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 12),

            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items:
                  [
                    "assets/images/banner1.png",
                    "assets/images/banner2.png",
                    "assets/images/banner3.jpg",
                  ].map((path) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                  children: [
                    sectionCard("assets/images/cards1.png", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => YtFeed()),
                      );
                    }),
                    sectionCard("assets/images/cards2.png", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LibraryFeed()),
                      );
                    }),
                    sectionCard("assets/images/cards3.png", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LettersFeed()),
                      );
                    }),
                    sectionCard("assets/images/cards4.png", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => WpFeed()),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionCard(String img, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(img, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
