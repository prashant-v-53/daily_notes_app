import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:notes_app/presentation/dashboard/edit_label/edit_label_controller.dart';
import 'package:notes_app/presentation/dashboard/home/home_controller.dart';

class LabelNameController extends GetxController {
  @override
  void onInit() async {
    QuerySnapshot labels = await FirebaseFirestore.instance
        .collection('Users')
        .doc(LocalStorage.deviceId)
        .collection("Labels")
        .get();

    for (var i = 0; i < labels.docs.length; i++) {
      labelNameList.add(LabelModel(
        label: labels.docs[i]["label"],
        labelID: labels.docs[i]["label_id"],
      ));
    }
    if (data!.label!.isNotEmpty) {
      titleList.value = data!.label!;
    }

    super.onInit();
  }

  AllNotesData? data = Get.arguments;

  RxList<LabelModel> labelNameList = RxList<LabelModel>([]);

  RxList<dynamic> titleList = RxList([]);

  onAddLabel() {
    if (data!.label != null) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(LocalStorage.deviceId)
          .collection("Notes")
          .doc(data!.noteId)
          .update(
        {"labels": titleList},
      );
    } else {}
  }
}
