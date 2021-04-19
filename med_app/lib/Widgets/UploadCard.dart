import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class UploadCard extends StatefulWidget {
  final title;
  final asset;
  final certType;
  final callback;
  UploadCard({this.title, this.asset, this.certType, this.callback});

  @override
  _UploadCardState createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {
  static FirebaseDatabase database = new FirebaseDatabase();
  final counterRef = database.reference().child('counter');
  DatabaseReference userRef = database.reference();
  // ignore: unused_field
  PlatformFile _image;
  File file;

  // addDocument(String document) async {
  //   var user = userRef.child(
  //       'Uesrs/Doctors/32FqmbJsHCTEMn8pgTXBnPLoAr82/Documents/${widget.certType}');
  //   final TransactionResult transactionResult =
  //       await counterRef.runTransaction((MutableData mutableData) async {
  //     mutableData.value = (mutableData.value ?? 0) + 1;
  //     return mutableData;
  //   });
  //
  //   if (transactionResult.committed) {
  //     user.set(document).then((_) {
  //       print('Transaction  committed.');
  //     });
  //   } else {
  //     print('Transaction not committed.');
  //     if (transactionResult.error != null) {
  //       print(transactionResult.error.message);
  //     }
  //   }
  // }

  Future imagePick() async {
    FilePickerResult documents = await FilePicker.platform.pickFiles();

    if (documents != null) {
      setState(() {
        // files = documents.paths.map((path) => File(path)).toList();
        file = File(documents.files.single.path);
      });
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    imagePick().then((_) {
      widget.callback(file.path);
      // for (var i = 0; i < files.length; i++) {
      Reference ref = storage.ref().child(file.path);
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.then((res) {
        res.ref.getDownloadURL();
        print('hi from below ${file.path}');
      });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return GestureDetector(
          onTap: () {
            uploadImageToFirebase(ctx);
          },
          child: Container(
            height: 100,
            child: Card(
              elevation: 3.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: ListTile(
                        title: Text(
                          widget.title,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Proxima',
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: AssetImage(widget.asset),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
