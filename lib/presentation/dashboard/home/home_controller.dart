import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/app_export.dart';
import '../../../core/network/network_info.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  void onInit() async {
    await getPinnedNote();
    await getAllNote();
    super.onInit();
  }

  RxBool isFlag = false.obs;
  RxBool isLoading = false.obs;

  RxList<AllNotesData> allNotesList = RxList<AllNotesData>([]);
  RxList<AllNotesData> pinnedNotesList = RxList<AllNotesData>([]);
  RxList imageList = [].obs;
  RxList deleteList = [].obs;

  onDataDelete(dynamic data) {
    if (deleteList.contains(data)) {
      deleteList.remove(data);
    } else {
      deleteList.add(data);
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

  String hFormat(DateTime date) {
    if (DateTime.now().difference(date).inDays == 1) {
      return "yesterday";
    } else if (DateTime.now().difference(date).inDays > 364) {
      return DateFormat('dd-MM-yyyy').format(date);
    } else if (DateTime.now().difference(date).inDays > 1) {
      return DateFormat('dd-MM-yyyy').format(date);
    } else {
      return DateFormat('hh:mm a').format(date);
    }
  }
}

class AllNotesData {
  int? backgroundId;
  int? colorId;
  String? noteId;
  String? notesContent;
  String? notesTitle;
  bool isPinned;
  Timestamp? createAt;
  List? label;

  AllNotesData({
    this.backgroundId,
    this.colorId,
    this.noteId,
    this.isPinned = false,
    this.notesContent,
    this.notesTitle,
    this.createAt,
    this.label,
  });

  factory AllNotesData.fromMap(Map<String, dynamic> map) {
    return AllNotesData(
      backgroundId: map["background_id"],
      colorId: map["color_id"],
      createAt: map["created_at"],
      isPinned: map["is_pinned"],
      noteId: map["note_id"],
      notesContent: map["notes_content"],
      notesTitle: map["notes_title"],
      label: map["labels"],
    );
  }
}
