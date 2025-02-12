// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:gallery_saver/gallery_saver.dart';

// class CameraPreviewScreen extends StatefulWidget {
//   final XFile video;
//   final bool isPicked;

//   const CameraPreviewScreen({
//     super.key,
//     required this.video,
//     required this.isPicked,
//   });

//   @override
//   State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
// }

// class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
//   late final VideoPlayerController _videoPlayerController;

//   bool _savedVideo = false;

//   Future<void> _initVideo() async {
//     _videoPlayerController = VideoPlayerController.file(
//       File(widget.video.path),
//     );

//     await _videoPlayerController.initialize();
//     await _videoPlayerController.setLooping(true);
//     await _videoPlayerController.play();

//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initVideo();
//   }

//   Future<void> _saveToGallery() async {
//     if (_savedVideo) return;

//     await GallerySaver.saveVideo(
//       widget.video.path,
//       albumName: "TikTok Clone!",
//     );

//     _savedVideo = true;

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text('Preview video'),
//         actions: [
//           if (!widget.isPicked)
//             IconButton(
//               onPressed: _saveToGallery,
//               icon: FaIcon(
//                 _savedVideo
//                     ? FontAwesomeIcons.check
//                     : FontAwesomeIcons.download,
//               ),
//             )
//         ],
//       ),
//       body: _videoPlayerController.value.isInitialized
//           ? VideoPlayer(_videoPlayerController)
//           : null,
//     );
//   }
// }
