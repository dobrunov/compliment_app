import 'package:flutter/material.dart';

import '../models/compliment_model.dart';
import '../styles/colors.dart';

class ComplimentsSumm extends StatelessWidget {
  const ComplimentsSumm({
    Key? key,
    required this.compliments,
  }) : super(key: key);

  final List<Compliment> compliments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Column(
          children: [
            Text(
              compliments.length.toString(),
              style: const TextStyle(
                color: AppColors.counterColorText,
                fontWeight: FontWeight.bold,
                fontSize: 58.0,
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
          ],
        ),
      ),
    );
  }
}