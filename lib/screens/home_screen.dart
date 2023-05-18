import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../screens/share_screen.dart';
import '../constants/constants.dart';
import '../models/compliment_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Compliment> compliments = [];

  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString('assets/compliments.json');
    final data = await json.decode(response);

    var list = data["items"] as List<dynamic>;

    setState(() {
      compliments = list.map((e) => Compliment.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    readJsonFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EBFA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  compliments.length.toString(),
                  style: const TextStyle(fontSize: 58.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  'COMPLIMENTS',
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/new-comp-screen');
                  },
                  child: const Text('CREATE'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            gap10,
            const Text('OR CHOOSE'),
            gap10,
            Expanded(
              child: ListView.builder(
                itemCount: compliments.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.fromLTRB(25, 2, 25, 2),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                        child: Center(
                          child: Text(
                            "'" + compliments[index].description + "'",
                            style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ShareScreen.routeName,
                          arguments: compliments[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            gap10,
            ElevatedButton(
              child: const Text('SHUFFLE'),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                compliments.shuffle();
                setState(() {});
              },
            ),
            gap10,
          ],
        ),
      ),
    );
  }
}
