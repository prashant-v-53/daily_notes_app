import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:notes_app/core/app_export.dart';
import 'package:notes_app/presentation/dashboard/draw/draw_controller.dart';
import 'package:painter/painter.dart';

class DrawScreen extends StatelessWidget {
  DrawScreen({super.key});
  final DrawController _controller = Get.put(DrawController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(
                Icons.undo,
              ),
              tooltip: 'Undo',
              onPressed: () {
                if (_controller.painterController.isEmpty) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          const Text('Nothing to undo'));
                } else {
                  _controller.painterController.undo();
                }
              }),
          IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Clear',
              onPressed: _controller.painterController.clear),
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () =>
                  show(_controller.painterController.finish(), context)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.deepOrange,
              child: Painter(_controller.painterController),
            ),
          ),
        ],
      ),
    );
  }

  void show(PictureDetails picture, BuildContext context) {
    _controller.finished.value = true;

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('View your image'),
        ),
        body: Container(
            alignment: Alignment.center,
            child: FutureBuilder<Uint8List>(
              future: picture.toPNG(),
              builder:
                  (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Image.memory(snapshot.data!);
                    }
                  default:
                    return const FractionallySizedBox(
                      widthFactor: 0.1,
                      alignment: Alignment.center,
                      child: AspectRatio(
                          aspectRatio: 1.0, child: CircularProgressIndicator()),
                    );
                }
              },
            )),
      );
    }));
  }
}
