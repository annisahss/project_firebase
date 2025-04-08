import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String userEmail = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  void _loadUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user?.email ?? 'guest@email.com';
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation logic if needed
    });
  }

  void _navigateTo(String page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(appBar: AppBar(title: Text(page))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.brown),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Assalamu’alaikum",
              style: TextStyle(color: Colors.brown),
            ),
            Text(
              userEmail,
              style: const TextStyle(color: Colors.brown, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.brown),
            onPressed: () {
              // Notification logic
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// === Carousel ===
            CarouselSlider(
              options: CarouselOptions(
                height: 160,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items:
                  List.generate(
                    4,
                    (index) => 'assets/image${index + 1}.png',
                  ).map((imagePath) {
                    return Builder(
                      builder: (context) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),

            const SizedBox(height: 20),

            /// === 4 Section Cards ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  sectionCard(
                    Icons.menu_book,
                    'Qur\'an Class',
                    () => _navigateTo('Qur\'an Class'),
                  ),
                  sectionCard(
                    Icons.mic,
                    'Podcast',
                    () => _navigateTo('Podcast'),
                  ),
                  sectionCard(
                    Icons.calendar_today,
                    'Event',
                    () => _navigateTo('Event'),
                  ),
                  sectionCard(
                    Icons.store,
                    'NN Store',
                    () => _navigateTo('NN Store'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      /// === Bottom Navigation ===
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  /// Reusable Section Card Widget
  Widget sectionCard(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.brown),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
