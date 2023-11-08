import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/app_export.dart';

class EditLabelController extends GetxController {
  RxList<LabelModel> labelList = RxList<LabelModel>([]);
  RxString label = "".obs;
  RxBool isCreate = true.obs;
  RxList edit = [].obs;

  Rx<TextEditingController> notesLable = TextEditingController(text: "").obs;

  RxString labelString = "".obs;
  RxString labelId = "".obs;

  @override
  void onInit() async {
    labelList.clear();

    QuerySnapshot labels = await FirebaseFirestore.instance
        .collection('Users')
        .doc(LocalStorage.deviceId)
        .collection("Labels")
        .get();

    for (var i = 0; i < labels.docs.length; i++) {
      labelList.add(LabelModel(
        label: labels.docs[i]["label"],
        labelID: labels.docs[i]["label_id"],
      ));
    }

    notesLable.value.text = labelString.value;

    super.onInit();
  }

  onCreate() {
    if (label.isNotEmpty) {
      var id = FirebaseFirestore.instance
          .collection('Users')
          .doc(LocalStorage.deviceId)
          .collection("Labels")
          .doc()
          .id;

      FirebaseFirestore.instance
          .collection('Users')
          .doc(LocalStorage.deviceId)
          .collection("Labels")
          .doc(id)
          .set({
        "label": label.value,
        "label_id": id,
      });
      labelList.add(
        LabelModel(
          label: label.value,
          labelID: id,
        ),
      );
      isCreate.value = false;
    } else {
      isCreate.value = false;
    }
  }

  onEdit() {
    if (notesLable.value.text.isNotEmpty) {
      print(labelId.value);

      FirebaseFirestore.instance
          .collection('Users')
          .doc(LocalStorage.deviceId)
          .collection("Labels")
          .doc(labelId.value)
          .update({
        "label": notesLable.value.text,
      });
    } else {}
  }
}

class LabelModel {
  String label, labelID;

  LabelModel({
    required this.label,
    required this.labelID,
  });
}
