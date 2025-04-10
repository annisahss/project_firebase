import 'package:flutter/material.dart';
import 'package:project_firebase/pages/wallpapers/wp_post.dart';
import 'package:project_firebase/services/storage/storage_service.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class WpFeed extends StatefulWidget {
  const WpFeed({super.key});

  @override
  State<WpFeed> createState() => _WpFeedState();
}

class _WpFeedState extends State<WpFeed> {
  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  // Fetch images from storage
  Future<void> fetchImages() async {
    await Provider.of<StorageService>(context, listen: false).fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageService>(
      builder: (context, storageService, child) {
        final List<String> imageUrls = storageService.imageUrls;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Wallpapers',
              style: GoogleFonts.bebasNeue(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color(0xffE69DB8),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  child: Text(
                    storageService.isUploading ? 'Uploading..' : '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => storageService.uploadImage(),
            child: const Icon(Icons.add),
            backgroundColor: const Color(0xffE69DB8),
          ),
          body: ListView.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              final String imageUrl = imageUrls[index];
              return WpPost(imageUrl: imageUrl);
            },
          ),
        );
      },
    );
  }
}
