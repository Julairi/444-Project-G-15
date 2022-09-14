import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethod {
// Create instance of class storage
  final FirebaseStorage _storage = FirebaseStorage.instance;

//For getting uiddd:
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Adding image to  firabse storage:
// child name is for storing folder name:

  Future<String> uploadImageToString(
    String childName,
    Uint8List file,
  ) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;

    /// Getting url from database
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
