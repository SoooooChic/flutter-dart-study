import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isFlashOn = false;
  bool _isBackCamera = true;
  bool _isPicking = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    WidgetsBinding.instance.addObserver(this);
    super.dispose();
  }

  Future<void> _checkPermissionsAndInit() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();

    if (_cameras == null || _cameras!.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      _isBackCamera ? _cameras!.first : _cameras!.last,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    await _cameraController!.initialize();

    if (!mounted) return;

    _isCameraInitialized = true;

    setState(() {});
  }

  Future<void> _takePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    final XFile photo = await _cameraController!.takePicture();

    if (mounted) {
      Navigator.pop(context, [photo.path]);
    }
  }

  Future<void> _pickImageFromGallery() async {
    if (_isPicking) return;
    _isPicking = true;

    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // if (image != null && mounted) {
    //   Navigator.pop(context, image.path);
    // }

    final List<XFile> images = await _picker.pickMultiImage(
      imageQuality: 50,
      maxHeight: 150,
      maxWidth: 150,
    );

    _isPicking = false; // 선택이 끝나면 다시 false로 변경

    if (images.isNotEmpty && mounted) {
      List<String> imagePaths = images.map((image) => image.path).toList();
      Navigator.pop(context, imagePaths);
    }
  }

  void _toggleFlash() async {
    if (_cameraController != null) {
      _isFlashOn = !_isFlashOn;
      await _cameraController!.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      setState(() {});
    }
  }

  void _switchCamera() async {
    _isBackCamera = !_isBackCamera;
    await _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: _isCameraInitialized && _cameraController != null
                ? CameraPreview(_cameraController!)
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      ),
                      onPressed: _toggleFlash,
                    ),
                    GestureDetector(
                      onTap: _takePhoto,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: Sizes.size44,
                            height: Sizes.size44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: Sizes.size56,
                            height: Sizes.size56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.cameraswitch, color: Colors.white),
                      onPressed: _switchCamera,
                    ),
                  ],
                ),
                Gaps.v20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Camera",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickImageFromGallery,
                      child: Text(
                        "Library",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
