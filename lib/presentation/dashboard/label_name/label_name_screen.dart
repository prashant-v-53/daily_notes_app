import 'package:flutter/material.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:notes_app/presentation/dashboard/label_name/label_name_controller.dart';

class LabelNameScreen extends StatelessWidget {
  LabelNameScreen({super.key});

  final LabelNameController _controller = Get.put(LabelNameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(_controller.labelNameList.length.toString()),
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(
              result: _controller.titleList,
            );
            // _controller.onAddLabel();
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Obx(
          () => ListView.builder(
            itemCount: _controller.labelNameList.length,
            itemBuilder: (context, index) {
              return Obx(
                () => ListTile(
                  leading: const Icon(
                    Icons.label_outline_rounded,
                    color: Colors.white,
                  ),
                  title: Text(
                    _controller.labelNameList[index].label,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white),
                    child: Checkbox(
                      checkColor: Colors.black,
                      activeColor: AppColors.appColor,
                      onChanged: (val) {
                        if (_controller.titleList
                            .contains(_controller.labelNameList[index].label)) {
                          _controller.titleList
                              .remove(_controller.labelNameList[index].label);
                        } else {
                          _controller.titleList
                              .add(_controller.labelNameList[index].label);
                        }
                      },
                      value: _controller.titleList
                          .contains(_controller.labelNameList[index].label),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
