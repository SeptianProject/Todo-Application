import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core.dart';
import 'package:todo_app/module/login/widget/dialog.dart';

class DashboardController extends State<DashboardView> {
  static late DashboardController instance;
  late DashboardView view;

  @override
  void initState() {
    loadImage();
    tap();
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  int selectedIndex = 1;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  File? image;
  String? imagePath;
  List<String> imageUrls = [];

  Future<void> uploadImage(File imageFile) async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      String fileName = '$email/${basename(imageFile.path)}';
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask task = ref.putFile(imageFile);
      TaskSnapshot snapshot = await task;
      String imageUrl = await snapshot.ref.getDownloadURL();
      log("Download Url :  $imageUrl");

      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('upload_image_url', imageUrl);

      setState(() {
        imagePath = imageUrl;
      });

      showSnackBar("Gambar berhasil diupload");
      log(imageUrl.length.toString());
    } catch (e) {
      showSnackBar("Gagal mengupload gambar");
    }
  }

  Future<void> tap() async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      String path = '$email/';

      final ListResult result =
          await FirebaseStorage.instance.ref().child(path).listAll();

      final List<String> urls = await Future.wait(result.items.map((ref) async {
        return await ref.getDownloadURL();
      }));

      setState(() {
        imageUrls = urls;
        log(imageUrls.length.toString());
      });
      showSnackBar("Berhasil mengambil gambar");
    } catch (e) {
      showSnackBar("Gagal mengambil gambar");
    }
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      imagePath = prefs.getString('upload_image_url') ?? " ";
    });
  }

  Future<void> getImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final imageTemp = File(pickedImage.path);
      setState(() => image = imageTemp);

      await uploadImage(imageTemp);
      log(imageTemp.length.toString());
    } catch (e) {
      showSnackBar("Gagal mengambil gambar");
    }
  }

  doLogout() async {
    await showAlertDialog(
      "Logout",
      "Apakah anda yakin ingin Logout wok?",
      () => Get.offAll(const LoginView()),
    );
  }

  // Future getImage() async {
  //   try {
  //     image =
  //         (await ImagePicker().pickImage(source: ImageSource.gallery)) as File?;
  //     if (image == null) return;
  //     final imageTemp = File(image!.path);
  //     setState(() => image = imageTemp);
  //   } catch (e) {
  //     showSnackBar("Gagal mengambil gambar");
  //   }
  // }

  // Future<XFile?> getImage() async {
  //   return await ImagePicker().pickImage(source: ImageSource.gallery);
  // }

  // Future<void> uploadFile(File filePath, String fileName) async {
  //   try {
  //     await FirebaseStorage.instance.ref().child(fileName).putFile(filePath);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // Future<String> getDownloadUrl(String fileName) async {
  //   try {
  //     return await FirebaseStorage.instance
  //         .ref()
  //         .child(fileName)
  //         .getDownloadURL();
  //   } catch (e) {
  //     return "";
  //   }
  // }

  // Future<void> deleteFile(String fileName) async {
  //   try {
  //     await FirebaseStorage.instance.ref().child(fileName).delete();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}
