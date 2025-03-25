import 'package:flutter/material.dart';
import 'package:project_firebase/services/storage/storage_service.dart';
import 'package:provider/provider.dart';

class WpPost extends StatelessWidget {
  final String imageUrl;

  const WpPost({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageService>(
      builder:
          (context, storageService, child) => Container(
            decoration: BoxDecoration(color: Color(0xffEFDCE9)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //delete button
                Container(
                  color: Color(0xffEFDCE9),
                  child: IconButton(
                    onPressed: () => storageService.deleteImage(imageUrl),

                    icon: const Icon(Icons.delete),
                  ),
                ),

                //image post
                Image.network(
                  imageUrl,
                  fit: BoxFit.fitWidth,
                  loadingBuilder: (context, child, loadingProgress) {
                    //loading circle..
                    if (loadingProgress != null) {
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                          ),
                        ),
                      );
                    } else {
                      return child;
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }
}
