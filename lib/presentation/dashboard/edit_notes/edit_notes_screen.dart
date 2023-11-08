import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:notes_app/core/utils/app_style.dart';
import 'package:notes_app/presentation/dashboard/edit_notes/edit_notes_controller.dart';
import 'package:share_plus/share_plus.dart';

class EditNotesScreen extends StatelessWidget {
  EditNotesScreen({super.key});
  final EditNotesController _controller = Get.put(EditNotesController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          _controller.onAdd();

          return true;
        },
        child: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(),
              child: _controller.selectedImage.value == 0
                  ? null
                  : Image.asset(
                      Appstyle.backgroundImage[_controller.selectedImage.value],
                      fit: BoxFit.cover,
                    ),
            ),
            Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: _controller.selectedImage.value == 0
                  ? Appstyle.cardsColor[_controller.selectedColor.value]
                  : Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      maxLines: null,
                      controller: _controller.notesTitle.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      maxLines: null,
                      controller: _controller.notesContent.value,
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Note",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ..._controller.labels
                            .asMap()
                            .map(
                              (i, value) => MapEntry(
                                i,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.4),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    _controller.labels[i],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .values
                            .toList(),
                        if (_controller.selectedImage.value != 0 &&
                            _controller.selectedColor.value != 0)
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Appstyle
                                  .cardsColor[_controller.selectedColor.value],
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xfff9bc75),
                                width: 2,
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                color: _controller.selectedImage.value == 0
                    ? Appstyle.cardsColor[_controller.selectedColor.value]
                    : Colors.transparent,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.bottomSheet(colorsPicker());
                          },
                          icon: const Icon(
                            Icons.palette_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Edited ${DateFormat("hh:mm a").format(DateTime.now())}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.bottomSheet(moreOption());
                      },
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget colorsPicker() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(20),
        color: _controller.selectedColor.value == 0
            ? const Color(0xff342a1e)
            : Appstyle.cardsColor[_controller.selectedColor.value],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Color",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: Appstyle.cardsColor.length,
                separatorBuilder: (context, index) => wSizedBox10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _controller.selectedColor.value = index;
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Appstyle.cardsColor[index],
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: _controller.selectedColor.value == index
                                ? const Color(0xfff9bc75)
                                : Colors.white.withOpacity(.7),
                            width: 2),
                      ),
                      child: _controller.selectedColor.value == index
                          ? const Icon(
                              Icons.done,
                              color: Color(0xfff9bc75),
                              size: 30,
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
            const Text(
              "Background",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            hSizedBox10,
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: Appstyle.backgroundImage.length,
                separatorBuilder: (context, index) => wSizedBox10,
                itemBuilder: (context, index) {
                  return Obx(
                    () => InkWell(
                      onTap: () {
                        _controller.selectedImage.value = index;
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xff342a1e),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: _controller.selectedImage.value == index
                                  ? const Color(0xfff9bc75)
                                  : Colors.black.withOpacity(.7),
                              width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: index == 0
                              ? const Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 40,
                                  color: Colors.white,
                                )
                              : Image.asset(
                                  Appstyle.backgroundImage[index],
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container moreOption() {
    return Container(
      color: const Color(0xff342a1e),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          option(
            icon: Icons.delete_outline_rounded,
            title: "Delete",
            onTap: () async {
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(LocalStorage.deviceId)
                  .collection("Notes")
                  .doc(_controller.data.noteId)
                  .delete()
                  .then((value) => Get.offAllNamed(AppRoute.home));

              Get.back();
            },
          ),
          option(
            icon: Icons.copy,
            title: "Make a copy",
            onTap: () async {
              Get.back();
            },
          ),
          option(
            icon: Icons.share_outlined,
            title: "Send",
            onTap: () {
              Share.share(
                _controller.notesTitle.toString(),
                subject: _controller.notesContent.toString(),
              );
            },
          ),
          option(
            icon: Icons.label_outline_rounded,
            title: "Labels",
            onTap: () async {
              _controller.result.value = await Get.toNamed(
                AppRoute.labelName,
                arguments: _controller.data,
              );

              Get.back();
            },
          ),
          hSizedBox10,
        ],
      ),
    );
  }

  InkWell option({
    required Function() onTap,
    required String title,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              wSizedBox20,
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
