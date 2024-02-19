import 'package:flutter/material.dart';

import '../models/compliment_model.dart';
import '../styles/colors.dart';
import '../widgets/compliment_button.dart';

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
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
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
                Navigator.pushNamed(
                  context,
                  '/share-screen',
                  arguments: Compliment(description: _newCompliment.text),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
