import 'package:flutter/material.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:notes_app/presentation/dashboard/edit_label/edit_label_controller.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});
  final EditLabelController _editLabelController =
      Get.put(EditLabelController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff342a1e),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hBox(50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Notes",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Colors.orangeAccent,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Labels",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(50),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _editLabelController.labelList.length,
              itemBuilder: (context, index) {
                return drawerList(
                  icon: Icons.label_outline_rounded,
                  title: _editLabelController.labelList[index].label,
                  onTap: () {
                    Get.toNamed(
                      AppRoute.labelWiseNote,
                      arguments: _editLabelController.labelList[index].label,
                    );
                  },
                );
              },
            ),
            drawerList(
              icon: Icons.add,
              title: "Create new label",
              onTap: () {
                Get.toNamed(
                  AppRoute.editLabel,
                );
              },
            ),
            const Divider(
              color: Colors.orangeAccent,
              thickness: 1,
            ),
            drawerList(
              icon: Icons.archive_outlined,
              title: "Archive",
              onTap: () {},
            ),
            drawerList(
              icon: Icons.delete_outline_rounded,
              title: "Trash",
              onTap: () {},
            ),
            drawerList(
              icon: Icons.settings_outlined,
              title: "Settings",
              onTap: () {},
            ),
            drawerList(
              icon: Icons.help_outline_outlined,
              title: "Help & feedback",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  ListTile drawerList({
    required IconData icon,
    required String title,
    required Function() onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
