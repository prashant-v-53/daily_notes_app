import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../home/home_controller.dart';

class EditNotesController extends GetxController {
  @override
  void onInit() {
    notesContent.value.text = data.notesContent ?? "";
    notesTitle.value.text = data.notesTitle ?? "";
    selectedColor.value = data.colorId!;
    selectedImage.value = data.backgroundId!;
    labels.value = data.label ?? [];
    result = labels;

    super.onInit();
  }

  AllNotesData data = Get.arguments;

  RxList result = [].obs;

  Rx<TextEditingController> notesTitle = TextEditingController(text: "").obs;
  Rx<TextEditingController> notesContent = TextEditingController(text: "").obs;

  RxInt selectedColor = 0.obs;
  RxInt selectedImage = 0.obs;

  RxList labels = [].obs;

  onAdd() async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(LocalStorage.deviceId)
          .collection("Notes")
          .doc(data.noteId)
          .update(
        {
          "background_id": selectedImage.value,
          "color_id": selectedColor.value,
          if (notesContent.value.text.isNotEmpty &&
              notesTitle.value.text.isNotEmpty)
            "created_at": DateTime.now(),
          "notes_content": notesContent.value.text.isNotEmpty
              ? notesContent.value.text
              : null,
          "notes_title":
              notesTitle.value.text.isNotEmpty ? notesTitle.value.text : null,
          "labels": result
        },
      );

      Get.back();
    } catch (e) {
      log(e.toString());
    }
  }
}
