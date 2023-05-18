import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../constants/constants.dart';
import '../models/compliment_model.dart';

//
class ShareScreen extends StatefulWidget {
  const ShareScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/share-screen';

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  late Compliment compliment;

  final controller = ScreenshotController();

  @override
  void didChangeDependencies() {
    compliment = ModalRoute.of(context)?.settings.arguments as Compliment;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EBFA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            gap25,
            Screenshot(
              controller: controller,
              child: ComplimentCard(compliment: compliment),
            ),
            gap25,
            ElevatedButton(
              child: const Text('SHARE'),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                final image = await controller.captureFromWidget(ComplimentCard(compliment: compliment));
                if (image.isEmpty) return;

                await saveImage(image);
                saveAndShare(image);
              },
            ),
          ],
        ),
      ),
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

class ComplimentCard extends StatelessWidget {
  const ComplimentCard({Key? key, required this.compliment}) : super(key: key);

  final Compliment compliment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "''" + compliment.description + "''",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
