import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:notes_app/presentation/dashboard/home/home_controller.dart';

import '../../../core/network/network_info.dart';

class LabelWiseNoteController extends GetxController {
  var title = Get.arguments;

  @override
  void onInit() async {
    await getPinnedNote();
    await getAllNote();

    super.onInit();
  }

  RxBool isFlag = false.obs;
  RxBool isLoading = false.obs;

  RxList deleteList = [].obs;
  RxList<AllNotesData> allNotesList = RxList<AllNotesData>([]);
  RxList<AllNotesData> pinnedNotesList = RxList<AllNotesData>([]);

  onDataDelete(dynamic data) {
    if (deleteList.contains(data["note_id"])) {
      deleteList.remove(data["note_id"]);
    } else {
      deleteList.add(data["note_id"]);
    }
  }

  Future getPinnedNote() async {
    try {
      isLoading.value = true;

      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        var data = FirebaseFirestore.instance
            .collection("Users")
            .doc(LocalStorage.deviceId)
            .collection("Notes")
            .where("labels", arrayContains: title)
            .where("is_pinned", isEqualTo: true)
            .snapshots();

        data.forEach((e) {
          pinnedNotesList.clear();
          e.docs.asMap().forEach((index, data) {
            pinnedNotesList.add(
              AllNotesData(
                backgroundId: data["background_id"],
                colorId: data["color_id"],
                createAt: data["created_at"],
                isPinned: data["is_pinned"],
                noteId: data["note_id"],
                notesContent: data["notes_content"],
                notesTitle: data["notes_title"],
                label: data["labels"],
              ),
            );
          });
        });

        isLoading.value = false;
      } else {
        toast("No connection");
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future getAllNote() async {
    try {
      isLoading.value = true;

      bool connection = await NetworkInfo(
        connectivity: Connectivity(),
      ).isConnected();
      if (connection) {
        var data = FirebaseFirestore.instance
            .collection("Users")
            .doc(LocalStorage.deviceId)
            .collection("Notes")
            .where("labels", arrayContains: title)
            .where("is_pinned", isEqualTo: false)
            .snapshots();

        data.forEach((e) {
          allNotesList.clear();
          e.docs.asMap().forEach((index, data) {
            allNotesList.add(
              AllNotesData(
                backgroundId: data["background_id"],
                colorId: data["color_id"],
                createAt: data["created_at"],
                isPinned: data["is_pinned"],
                noteId: data["note_id"],
                notesContent: data["notes_content"],
                notesTitle: data["notes_title"],
                label: data["labels"],
              ),
            );
          });
        });

        isLoading.value = false;
      } else {
        toast("No connection");
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
