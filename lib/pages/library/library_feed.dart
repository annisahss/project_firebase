import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'library_view.dart';
import 'dart:io';

class LibraryFeed extends StatefulWidget {
  const LibraryFeed({super.key});

  @override
  State<LibraryFeed> createState() => _LibraryFeedState();
}

class _LibraryFeedState extends State<LibraryFeed> {
  List<Map<String, String>> _pdfFiles = [];

  @override
  void initState() {
    super.initState();
    _fetchPDFFiles();
  }

  Future<void> _fetchPDFFiles() async {
    final ListResult result =
        await FirebaseStorage.instance.ref('pdfs').listAll();
    final files = await Future.wait(
      result.items.map((ref) async {
        final url = await ref.getDownloadURL();
        return {'name': ref.name, 'url': url};
      }),
    );
    setState(() => _pdfFiles = files);
  }

  Future<void> _uploadPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      final file = result.files.single;
      final filePath = file.path!;
      final ref = FirebaseStorage.instance.ref('pdfs/${file.name}');
      await ref.putFile(File(filePath));
      _fetchPDFFiles(); // refresh list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Champs Library',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xffE69DB8),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: _uploadPDF,
          ),
        ],
      ),
      body:
          _pdfFiles.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _pdfFiles.length,
                itemBuilder: (context, index) {
                  final file = _pdfFiles[index];
                  return ListTile(
                    title: Text(file['name']!),
                    leading: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => LibraryView(
                                  pdfName: file['name']!,
                                  pdfUrl: file['url']!,
                                ),
                          ),
                        ),
                  );
                },
              ),
    );
  }
}
