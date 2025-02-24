import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class HttpService {
  final http.Client _client;

  HttpService({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<String> downloadAndResizeImage(String url, String fileName) async {
    try {
      // Download gambar dari URL
      final response = await http.get(Uri.parse(url));
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      // Simpan gambar asli ke file lokal
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // Decode gambar menggunakan package image
      final img.Image? image = img.decodeImage(file.readAsBytesSync());
      if (image == null) throw Exception("Gagal decode gambar");

      // Resize gambar ke 600x200 px
      final img.Image resized = img.copyResize(image, width: 400, height: 800);

      // Simpan gambar yang sudah di-resize
      final resizedFile = File(filePath)
        ..writeAsBytesSync(img.encodeJpg(resized));
      return resizedFile.path;
    } catch (e) {
      print("Error resizing image: $e");
      return url; // Jika gagal, tetap gunakan URL asli
    }
  }

  Future<String> downloadAndSaveFile(String url, String fileName) async {
    final bytes = await getByteArrayFromUrl(url);

    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final File file = File(filePath);
    await file.writeAsBytes(bytes);

    // if (fileName == 'bigPicture.jpg') {
    //   final img.Image? image = img.decodeImage(file.readAsBytesSync());
    //   final img.Image resized =
    //       img.copyResize(image!, width: 1024, height: 512);

    //   final resizedFile = File(filePath)
    //     ..writeAsBytesSync(img.encodeJpg(resized));

    //   return resizedFile.path;
    // } else {
    return filePath;
    // }
  }

  Future<String> getDataFromUrl(String url) async {
    final response = await _client.get(Uri.parse(url));
    return response.body;
  }

  Future<Uint8List> getByteArrayFromUrl(String url) async {
    final response = await _client.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<String> getBase64FromUrl(String url) async {
    final bytes = await getByteArrayFromUrl(url);
    return base64Encode(bytes);
  }
}
