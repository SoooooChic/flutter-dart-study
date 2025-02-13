import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'result_screen.dart';

class PhotoCamScreen extends StatefulWidget {
  const PhotoCamScreen({super.key});

  @override
  _PhotoCamScreenState createState() => _PhotoCamScreenState();
}

class _PhotoCamScreenState extends State<PhotoCamScreen> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  final ImagePicker _picker = ImagePicker();
  bool _isCameraInitialized = false;
  bool _isPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndInit();
  }

  /// 📌 카메라 권한 확인 및 초기화
  Future<void> _checkPermissionsAndInit() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _initializeCamera();
    } else {
      setState(() {
        _isPermissionGranted = false;
      });
    }
  }

  /// 📌 카메라 초기화
  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _cameraController =
            CameraController(_cameras[0], ResolutionPreset.medium);
        await _cameraController!.initialize();
        setState(() {
          _isCameraInitialized = true;
          _isPermissionGranted = true;
        });
      }
    } catch (e) {
      print("카메라 초기화 오류: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  /// 📌 사진 촬영
  Future<void> _takePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    try {
      final XFile photo = await _cameraController!.takePicture();
      _navigateToResultScreen(photo.path);
    } catch (e) {
      print("사진 촬영 오류: $e");
    }
  }

  /// 📌 갤러리에서 사진 선택
  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _navigateToResultScreen(image.path);
    }
  }

  /// 📌 결과 페이지로 이동
  void _navigateToResultScreen(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("사진 촬영 및 선택")),
      body: Column(
        children: [
          Expanded(
            child: _isPermissionGranted
                ? (_isCameraInitialized
                    ? CameraPreview(_cameraController!)
                    : const Center(child: CircularProgressIndicator()))
                : _buildPermissionDenied(),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  /// 📌 권한 거부 시 화면
  Widget _buildPermissionDenied() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.camera_alt, size: 80, color: Colors.grey),
          const SizedBox(height: 10),
          const Text("카메라 권한이 필요합니다."),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _checkPermissionsAndInit,
            child: const Text("권한 요청"),
          ),
        ],
      ),
    );
  }

  /// 📌 하단 버튼 영역
  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            label: const Text("사진 촬영"),
            onPressed: _takePhoto,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.photo_library),
            label: const Text("갤러리 선택"),
            onPressed: _pickImageFromGallery,
          ),
        ],
      ),
    );
  }
}
