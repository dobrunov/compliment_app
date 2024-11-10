import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../models/compliment_model.dart';

class ComplimentListNotifier extends StateNotifier<List<Compliment>> {
  ComplimentListNotifier() : super([]);

  Future<void> loadCompliments() async {
    final String response = await rootBundle.loadString('assets/compliments.json');
    final data = await json.decode(response);
    var list = data["items"] as List<dynamic>;
    state = list.map((e) => Compliment.fromJson(e)).toList();
  }

  void shuffleCompliments() {
    state.shuffle();
    state = [...state];
  }
}

final complimentListProvider = StateNotifierProvider<ComplimentListNotifier, List<Compliment>>((ref) {
  return ComplimentListNotifier();
});
