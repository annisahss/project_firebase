import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class LibraryView extends StatefulWidget {
  final String pdfUrl;
  final String pdfName;

  const LibraryView({required this.pdfUrl, required this.pdfName, super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  String? localPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _downloadPdf();
  }

  Future<void> _downloadPdf() async {
    final response = await http.get(Uri.parse(widget.pdfUrl));
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${widget.pdfName}');
    await file.writeAsBytes(response.bodyBytes, flush: true);
    setState(() {
      localPath = file.path;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pdfName)),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : PDFView(
                filePath: localPath!,
                autoSpacing: true,
                pageFling: true,
              ),
    );
  }
}
