import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DailyLifeProvider extends ChangeNotifier {
  List<dynamic> sections = [];

  bool isLoading = true;

  Future<void> loadJson() async {
    final String response =
        await rootBundle.loadString('assets/daily_life/daily_life.json');
    final data = await json.decode(response);

    sections = data;

    isLoading = false;

    notifyListeners();
  }
}
