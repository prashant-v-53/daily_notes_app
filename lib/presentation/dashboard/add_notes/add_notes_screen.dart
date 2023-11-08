import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:notes_app/presentation/dashboard/add_notes/add_notes_controller.dart';

import '../../../core/utils/app_style.dart';

class AddNotesScreen extends StatelessWidget {
  AddNotesScreen({super.key});

  final AddNotesController _controller = Get.put(AddNotesController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _controller.onAdd();

        return true;
      },
      child: Obx(
        () => Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Appstyle.cardsColor[_controller.selectedColor.value]),
              child: _controller.selectedImage.value == 0
                  ? null
                  : Image.asset(
                      Appstyle.backgroundImage[_controller.selectedImage.value],
                      fit: BoxFit.cover,
                    ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    _controller.onAdd();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
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
                      onChanged: (val) {
                        _controller.notesTitle.value = val;
                      },
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      maxLines: null,
                      onChanged: (val) {
                        _controller.notesContent.value = val;
                      },
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
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
                    hBox(50),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ..._controller.result!
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
                                    _controller.result![i],
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
                        Icons.more_vert,
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
              height: 90,
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
                  return InkWell(
                    onTap: () {
                      _controller.selectedImage.value = index;
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xfff9bc75),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: _controller.selectedColor.value == index
                                ? const Color(0xfff9bc75)
                                : Colors.white.withOpacity(.7),
                            width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: index == 0
                            ? const Icon(Icons.image)
                            : Image.asset(
                                Appstyle.backgroundImage[index],
                                fit: BoxFit.cover,
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
              Get.back();
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
              Get.back();
            },
          ),
          option(
            icon: Icons.label_outline_rounded,
            title: "Labels",
            onTap: () async {
              _controller.result!.value = await Get.toNamed(
                AppRoute.labelName,
              );
              Get.back();
            },
          ),
          hSizedBox10,
        ],
      ),
    );
  }
}
