// import 'dart:io';
// import 'dart:async';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/services.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

// class LibraryApi {
//   static Future<File> loadNetwork (String url) async {
//     final response = await http.get(url);
//     final bytes = response.bodyBytes; 

//     return _storeFile(url, bytes);
//   }

//     static Future<File> _storeFile (String url, List<int> bytes) {
//       final filename = basename(url);
//       final dir = await getApplicationDocumentsDirectory();

//       final file = File('${dir.path}/$filename');
//       await file.writeAsBytes(bytes, flush:true);
//       return file;
//     }



// }