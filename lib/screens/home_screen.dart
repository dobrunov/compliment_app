import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const.dart';
import '../models/compliment_model.dart';
import '../screens/share_screen.dart';
import '../styles/app_dimens.dart';
import '../styles/colors.dart';
import '../widgets/compliment_button.dart';
import '../widgets/compliments_summ.dart';

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
            ///
            ComplimentsSumm(compliments: compliments),
            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ComplimentButton(
                  text: 'CREATE',
                  onPressed: () {
                    Navigator.pushNamed(context, '/new-comp-screen');
                  },
                ),
              ],
            ),
            ///
            SizedBoxHeight10,
            ///
            const Text(
              'OR CHOOSE',
              style: const TextStyle(
                color: AppColors.appTextColor,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            ///
            SizedBoxHeight10,
            ///
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
            ///
            SizedBoxHeight10,
            ///
            ComplimentButton(
              text: 'SHUFFLE',
              onPressed: () {
                compliments.shuffle();
                setState(() {});
              },
            ),
            ///
            SizedBoxHeight10,
          ],
        ),
      ),
    );
  }
}




