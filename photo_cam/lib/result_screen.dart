import 'dart:io';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String imagePath;

  const ResultScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("선택한 사진")),
      body: Center(
        child: imagePath.isNotEmpty
            ? Image.file(File(imagePath))
            : Text("이미지가 없습니다."),
      ),
    );
  }
}
