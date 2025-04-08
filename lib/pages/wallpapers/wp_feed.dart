import 'package:flutter/material.dart';
import 'package:project_firebase/pages/wallpapers/wp_post.dart';
import 'package:project_firebase/services/storage/storage_service.dart';
import 'package:provider/provider.dart';

class WpFeed extends StatefulWidget {
  const WpFeed({super.key});

  @override
  State<WpFeed> createState() => WpFeedgetState();
}

class WpFeedgetState extends State<WpFeed> {
  @override
  void initState() {
    super.initState();

    fetchImages();
  }

  //fetch images
  Future<void> fetchImages() async {
    await Provider.of<StorageService>(context, listen: false).fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageService>(
      builder: (context, storageService, child) {
        //list of image urls
        final List<String> imageUrls = storageService.imageUrls;

        //home page wallpapers feed UI
        return Scaffold(
          appBar: AppBar(
            title: Text(
              storageService.isUploading ? 'Uploading..' : '',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                backgroundColor: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => storageService.uploadImage(),
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              //get each individual image
              final String imageUrl = imageUrls[index];
              print("gjhh");
              //image post UI
              return WpPost(imageUrl: imageUrl);
            },
          ),
        );
      },
    );
  }
}
