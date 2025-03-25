import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_firebase/pages/auth/auth_page.dart';
import 'package:project_firebase/pages/home_page.dart';
import 'package:project_firebase/pages/letters/letters_feed.dart';
import 'package:project_firebase/pages/library/library_feed.dart';
import 'package:project_firebase/pages/wallpapers/wp_feed.dart';
import 'package:project_firebase/pages/youtube/yt_feed.dart';
import 'package:project_firebase/services/auth_service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthService _authService = AuthService();
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  //sign user out method
  void signUserOut() {
    _authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/hp_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.grey[700]),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.grey[700]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.grey[700]),
            onPressed: signUserOut,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink[200],
        unselectedItemColor: Colors.grey[700],
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home Page'),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Meet Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pages_rounded),
            label: 'Love Letters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallpaper_rounded),
            label: 'Wallpapers',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                ),
            child: HomePage(),
          ),
          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YtFeed()),
                ),
            child: YtFeed(),
          ),
          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LibraryFeed()),
                ),
            child: LibraryFeed(),
          ),
          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LettersFeed()),
                ),
            child: LettersFeed(),
          ),
          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WpFeed()),
                ),
            child: WpFeed(),
          ),
          // GestureDetector(
          //   onTap:
          //       () => Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => MixtapesFeed()),
          //       ),
          //   child: MixtapesFeed(),
          // ),
        ],
      ),
    );
  }
}
