import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:notes_app/presentation/dashboard/label_wise_note/label_wise_note_controller.dart';

import '../../../core/utils/app_style.dart';

class LabelWiseNoteScreen extends StatelessWidget {
  LabelWiseNoteScreen({super.key});

  final LabelWiseNoteController _controller =
      Get.put(LabelWiseNoteController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: _controller.deleteList.isNotEmpty
            ? AppBar(
                backgroundColor: AppColors.backgroundColor,
                leading: IconButton(
                  onPressed: () {
                    _controller.deleteList.clear();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  _controller.deleteList.length.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                titleTextStyle: const TextStyle(color: Colors.white),
                actions: [
                  IconButton(
                    onPressed: () {
                      for (var element in _controller.deleteList) {
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(LocalStorage.deviceId)
                            .collection("Notes")
                            .doc(element.toString())
                            .update({
                          "is_pinned":
                              _controller.isFlag.value == false ? true : false
                        });
                      }
                      _controller.deleteList.clear();
                    },
                    icon: const Icon(
                      Icons.push_pin_outlined,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      for (var element in _controller.deleteList) {
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(LocalStorage.deviceId)
                            .collection("Notes")
                            .doc(element.toString())
                            .delete();
                      }
                      _controller.deleteList.clear();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            : AppBar(
                backgroundColor: AppColors.backgroundColor,
                title: Text(
                  _controller.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
        body: _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.allNotesList.isEmpty &&
                    _controller.pinnedNotesList.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      wBox(Get.width),
                      const Icon(
                        Icons.label_outline_rounded,
                        color: Colors.white,
                        size: 100,
                      ),
                      const Text(
                        "No notes with this label yet",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if (_controller.pinnedNotesList.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              label("Pinned"),
                              hSizedBox20,
                              StaggeredGrid.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 12,
                                children: List.generate(
                                  _controller.pinnedNotesList.length,
                                  (index) {
                                    var data =
                                        _controller.pinnedNotesList[index];

                                    if (data.notesTitle == null &&
                                        data.notesContent == null &&
                                        data.label == null) {
                                      for (var i = 0;
                                          i < data.noteId!.length;
                                          i++) {
                                        FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(LocalStorage.deviceId)
                                            .collection("Notes")
                                            .doc(data.noteId)
                                            .delete();
                                      }
                                    }

                                    return Obx(
                                      () => InkWell(
                                        onTap: () {
                                          if (_controller.deleteList.isEmpty) {
                                            Get.toNamed(
                                              AppRoute.editNotes,
                                              arguments: data,
                                            );
                                          } else {
                                            _controller
                                                .onDataDelete(data.noteId);

                                            _controller.isFlag.value =
                                                data.isPinned;
                                          }
                                        },
                                        onLongPress: () {
                                          _controller.onDataDelete(data.noteId);

                                          _controller.isFlag.value =
                                              data.isPinned;
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Appstyle
                                                .cardsColor[data.colorId!],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: data.backgroundId != 0
                                                ? DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      Appstyle.backgroundImage[
                                                          data.backgroundId!],
                                                    ),
                                                  )
                                                : null,
                                            border: _controller.deleteList
                                                    .contains(data.noteId)
                                                ? Border.all(
                                                    color: Colors.white,
                                                    width: 2.5,
                                                  )
                                                : Border.all(
                                                    color: data.colorId == 0
                                                        ? AppColors.appColor
                                                        : Appstyle.cardsColor[
                                                            data.colorId!],
                                                  ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (data.notesTitle != null)
                                                  Text(
                                                    data.notesTitle!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: Appstyle.mainTitle,
                                                  ),
                                                hSizedBox10,
                                                if (data.notesContent != null)
                                                  Text(
                                                    data.notesContent!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 10,
                                                    style: Appstyle.mainContent,
                                                  ),
                                                hSizedBox10,
                                                Wrap(
                                                  spacing: 8,
                                                  runSpacing: 8,
                                                  children: [
                                                    if (data.label != null)
                                                      ...List.generate(
                                                          data.label!.length > 2
                                                              ? 2
                                                              : data.label!
                                                                  .length, (i) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 6),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    .4),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          child: Text(
                                                            data.label![i],
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    if (data.label != null &&
                                                        data.label!.length > 2)
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                        child: Text(
                                                          "+ ${data.label!.length - 2}",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    if (data.backgroundId !=
                                                            0 &&
                                                        data.colorId != 0)
                                                      Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Appstyle
                                                                  .cardsColor[
                                                              data.colorId!],
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xfff9bc75),
                                                            width: 2,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              hSizedBox20,
                              label("Other"),
                            ],
                          ),
                        hSizedBox20,
                        StaggeredGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          children: List.generate(
                            _controller.allNotesList.length,
                            (index) {
                              var data = _controller.allNotesList[index];

                              if (data.notesTitle == null &&
                                  data.notesContent == null &&
                                  data.label == null) {
                                for (var i = 0; i < data.noteId!.length; i++) {
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(LocalStorage.deviceId)
                                      .collection("Notes")
                                      .doc(data.noteId)
                                      .delete();
                                }
                              }

                              return Obx(
                                () => InkWell(
                                  onTap: () {
                                    if (_controller.deleteList.isEmpty) {
                                      Get.toNamed(
                                        AppRoute.editNotes,
                                        arguments: data,
                                      );
                                    } else {
                                      _controller.onDataDelete(data.noteId);

                                      _controller.isFlag.value = data.isPinned;
                                    }
                                  },
                                  onLongPress: () {
                                    _controller.onDataDelete(data.noteId);

                                    _controller.isFlag.value = data.isPinned;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Appstyle.cardsColor[data.colorId!],
                                      borderRadius: BorderRadius.circular(8),
                                      image: data.backgroundId != 0
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                Appstyle.backgroundImage[
                                                    data.backgroundId!],
                                              ),
                                            )
                                          : null,
                                      border: _controller.deleteList
                                              .contains(data.noteId)
                                          ? Border.all(
                                              color: Colors.white,
                                              width: 2.5,
                                            )
                                          : Border.all(
                                              color: data.colorId == 0
                                                  ? AppColors.appColor
                                                  : Appstyle.cardsColor[
                                                      data.colorId!],
                                            ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (data.notesTitle != null)
                                            Text(
                                              data.notesTitle!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: Appstyle.mainTitle,
                                            ),
                                          hSizedBox10,
                                          if (data.notesContent != null)
                                            Text(
                                              data.notesContent!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 10,
                                              style: Appstyle.mainContent,
                                            ),
                                          hSizedBox10,
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: [
                                              if (data.label != null)
                                                ...List.generate(
                                                    data.label!.length > 2
                                                        ? 2
                                                        : data.label!.length,
                                                    (i) {
                                                  return Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 6),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(.4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: Text(
                                                      data.label![i],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              if (data.label != null &&
                                                  data.label!.length > 2)
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Text(
                                                    "+ ${data.label!.length - 2}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              if (data.backgroundId != 0 &&
                                                  data.colorId != 0)
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    color: Appstyle.cardsColor[
                                                        data.colorId!],
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xfff9bc75),
                                                      width: 2,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        hSizedBox20,
                      ],
                    ),
                  ),
      ),
    );
  }

  Text label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
