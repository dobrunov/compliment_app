import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../constants/constants.dart';
import '../models/compliment_model.dart';
import '../widgets/compliment_card.dart';
import '../widgets/share_button.dart';

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
            ShareButton(
              compliment: compliment,
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
