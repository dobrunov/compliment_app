import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../const.dart';
import '../screens/share_screen.dart';
import '../models/compliment_model.dart';
import '../styles/app_dimens.dart';
import '../styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Compliment> compliments = [];

  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString(complimentJson);
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
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  compliments.length.toString(),
                  style: const TextStyle(
                    color: AppColors.counterColorText,
                    fontWeight: FontWeight.bold,
                    fontSize: 58.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  'COMPLIMENTS',
                  style: const TextStyle(
                    color: AppColors.appTextColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
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
                  child: const Text(
                    'CREATE',
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
            SizedBoxHeight10,
            const Text(
              'OR CHOOSE',
              style: const TextStyle(
                color: AppColors.appTextColor,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBoxHeight10,
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
                            style: TextStyle(
                              color: AppColors.appTextColor,
                              fontSize: 14.0,
                              fontStyle: FontStyle.italic,
                            ),
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
            SizedBoxHeight10,
            ElevatedButton(
              child: const Text(
                'SHUFFLE',
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
              onPressed: () {
                compliments.shuffle();
                setState(() {});
              },
            ),
            SizedBoxHeight10,
          ],
        ),
      ),
    );
  }
}
