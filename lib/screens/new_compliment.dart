import 'package:flutter/material.dart';

import '../models/compliment_model.dart';

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
      backgroundColor: const Color(0xFFE8EBFA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFC4CBED), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: TextField(
                controller: _newCompliment,
                decoration: InputDecoration(
                  labelText: 'Enter your compliment',
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
              child: const Text('OK'),
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
