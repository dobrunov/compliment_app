import 'package:flutter/material.dart';

import '../models/compliment_model.dart';
import '../styles/colors.dart';

class NewCompliment extends StatefulWidget {
  const NewCompliment({Key? key}) : super(key: key);

  static const String routeName = '/new-comp-screen';

  @override
  _NewComplimentState createState() => _NewComplimentState();
}

class _NewComplimentState extends State<NewCompliment> {
  final TextEditingController _newCompliment = TextEditingController();

  @override
  void dispose() {
    _newCompliment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.textFieldBackgroundColor,
                border: Border.all(color: AppColors.textFieldBorderColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/share-screen',
                  arguments: Compliment(description: _newCompliment.text),
                );
              },
              child: const Text(
                'OK',
                style: const TextStyle(
                  color: AppColors.appButtonTextColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
