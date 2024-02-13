import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../models/compliment_model.dart';
import 'compliment_button.dart';
import 'compliment_card.dart';

class ShareButton extends StatelessWidget {
  ShareButton({
    Key? key,
    required this.controller,
    required this.compliment,
  }) : super(key: key);

  late final ScreenshotController controller;
  late final Compliment compliment;

  @override
  Widget build(BuildContext context) {
    return ComplimentButton(
      text: 'SHARE',
      onPressed: () async {
        final image = await controller.captureFromWidget(
          ComplimentCard(
            compliment: compliment,
          ),
        );
        if (image.isEmpty) return;

        await saveImage(image);
        saveAndShare(image);
      },
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareXFiles([XFile(image.path)]);
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now().toIso8601String().replaceAll('.', '_').replaceAll(':', '_');
    final name = "screenshot_$time";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }
}
