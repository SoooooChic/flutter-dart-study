import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageProvider = Provider((ref) => FirebaseStorage.instance);

class StorageService {
  final FirebaseStorage _storage;
  StorageService(this._storage);

  Future<String> uploadFile(
      String path, String fileName, Uint8List fileData) async {
    final ref = _storage.ref().child('$path/$fileName');
    final uploadTask = ref.putData(fileData);
    await uploadTask;
    return await ref.getDownloadURL();
  }
}

final storageServiceProvider = Provider((ref) {
  return StorageService(ref.watch(firebaseStorageProvider));
});
