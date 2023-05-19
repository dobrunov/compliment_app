import 'package:flutter/material.dart';

import '../models/compliment_model.dart';
import '../styles/colors.dart';

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
        color: AppColors.cardColorBackground,
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
                  color: AppColors.cardColorText,
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
