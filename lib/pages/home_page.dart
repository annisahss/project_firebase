import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  final List<String> youtubeLinks = [
    'YouTube',
    'YouTube',
    'YouTube',
    'YouTube',
  ];
  final List<String> pdfLinks = ['PDF', 'PDF', 'PDF', 'PDF'];
  final List<String> emailLinks = ['Email', 'Email', 'Email', 'Email'];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Banner
            CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                viewportFraction: 0.8, // Adjust this to control spacing
              ),
              items:
                  [
                    "assets/images/banner1.png",
                    "assets/images/banner2.png",
                    "assets/images/banner3.jpg",
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.green),
                          child: Image.asset(i, fit: BoxFit.cover),
                        );
                      },
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
