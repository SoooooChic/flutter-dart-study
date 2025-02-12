import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("사용 가능한 카메라가 없습니다.")),
      );
      return;
    }

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );

    await _controller!.initialize();
    if (!mounted) return;

    setState(() => _isCameraInitialized = true);
  }

  Future<void> _captureAndSave() async {
    if (!_isCameraInitialized || _controller == null) return;

    // 저장 권한 요청 (Android)
    if (Platform.isAndroid && await Permission.storage.request().isDenied) {
      return;
    }

    // 카메라 촬영
    final XFile file = await _controller!.takePicture();
    final String filePath = file.path;

    // 갤러리에 저장
    final result = await ImageGallerySaver.saveFile(filePath);
    if (result['isSuccess'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("사진 저장 완료! 📸")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("사진 저장 실패 ❌")),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("카메라 촬영 & 저장")),
      body: _isCameraInitialized
          ? CameraPreview(_controller!)
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: _captureAndSave,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
