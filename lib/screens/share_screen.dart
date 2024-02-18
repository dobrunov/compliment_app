import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../models/compliment_model.dart';
import '../styles/app_dimens.dart';
import '../styles/colors.dart';
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

  final screenshotController = ScreenshotController();

  @override
  void didChangeDependencies() {
    compliment = ModalRoute.of(context)?.settings.arguments as Compliment;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //
            Screenshot(
              controller: screenshotController,
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: ComplimentCard(compliment: compliment),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: ShareButton(
                compliment: compliment,
                controller: screenshotController,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
