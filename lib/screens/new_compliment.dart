import 'package:compliments_app/router/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/compliment_model.dart';
import '../styles/colors.dart';
import '../widgets/compliment_button.dart';

class NewCompliment extends StatefulWidget {
  const NewCompliment({Key? key}) : super(key: key);

  @override
  _NewComplimentState createState() => _NewComplimentState();
}

class _NewComplimentState extends State<NewCompliment> {
  final TextEditingController _newCompliment = TextEditingController();
  Compliment compliment = Compliment(description: '');

  @override
  void dispose() {
    _newCompliment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(backgroundColor: AppColors.backgroundColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                width: screenWidth * 0.8,
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  color: AppColors.textFieldBackgroundColor,
                  border: Border.all(color: AppColors.textFieldBorderColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                ),
                child: TextField(
                  controller: _newCompliment,
                  decoration: InputDecoration(
                    labelText: 'Enter your compliment',
                    labelStyle: TextStyle(color: AppColors.textFieldTextLabelColor),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            ComplimentButton(
              text: 'OK',
              onPressed: () {
                compliment.description = _newCompliment.text;
                context.push(ScreenRoutes.share, extra: compliment);
              },
            ),
          ],
        ),
      ),
    );
  }
}
