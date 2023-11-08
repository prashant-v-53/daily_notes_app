import 'package:flutter/material.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:notes_app/presentation/dashboard/edit_label/edit_label_controller.dart';

class EditLabelScreen extends StatelessWidget {
  EditLabelScreen({super.key});
  final EditLabelController _controller = Get.put(EditLabelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: false,
        title: const Text(
          "Edit labels",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              _controller.isCreate.value == true
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _controller.isCreate.value = false;
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          wSizedBox20,
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.white,
                              onChanged: (val) {
                                _controller.label.value = val;
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Create new labels",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(.8)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _controller.onCreate();
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        _controller.isCreate.value = true;
                      },
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _controller.isCreate.value = true;
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          wSizedBox20,
                          Text(
                            "Create new labels",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(.8)),
                          )
                        ],
                      ),
                    ),
              if (_controller.labelList.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controller.labelList.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          if (_controller.edit.contains(index)) {
                            _controller.edit.remove(index);
                          } else {
                            _controller.edit.clear();
                            _controller.edit.add(index);
                          }

                          _controller.labelString.value =
                              _controller.labelList[index].label;

                          _controller.labelId.value =
                              _controller.labelList[index].labelID;
                        },
                        leading: _controller.edit.contains(index)
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              )
                            : IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.label_outline_rounded,
                                  color: Colors.white,
                                ),
                              ),
                        title: _controller.edit.contains(index)
                            ? TextField(
                                cursorColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                controller: _controller.notesLable.value,
                                decoration: InputDecoration(
                                  hintText: "Create new labels",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(.8)),
                                  border: InputBorder.none,
                                ),
                              )
                            : Text(
                                _controller.labelList[index].label,
                                style: const TextStyle(color: Colors.white),
                              ),
                        trailing: _controller.edit.contains(index)
                            ? IconButton(
                                onPressed: () {
                                  _controller.onEdit();
                                },
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                              )
                            : IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
