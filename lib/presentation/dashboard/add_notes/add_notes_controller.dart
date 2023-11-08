import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/core/app_export.dart';

class AddNotesController extends GetxController {
  RxString notesTitle = "".obs;
  RxString notesContent = "".obs;

  RxInt selectedColor = 0.obs;
  RxInt selectedImage = 0.obs;

  RxList? result = [].obs;

  onAdd() async {
    try {
      var id = FirebaseFirestore.instance
          .collection("Users")
          .doc(LocalStorage.deviceId)
          .collection("Notes")
          .doc()
          .id;

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(LocalStorage.deviceId)
          .collection("Notes")
          .doc(id)
          .set(
        {
          "background_id": selectedImage.value,
          "note_id": id,
          "color_id": selectedColor.value,
          "created_at": DateTime.now(),
          "is_pinned": false,
          "notes_content":
              notesContent.value.isNotEmpty ? notesContent.value : null,
          "notes_title": notesTitle.value.isNotEmpty ? notesTitle.value : null,
          "labels": result!.isNotEmpty ? result : null
        },
      );

      Get.back();
    } catch (e) {
      log(e.toString());
    }
  }
}
