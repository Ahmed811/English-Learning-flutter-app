import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JobSectionProvider extends ChangeNotifier {
  List<dynamic> _items = [];
  List<dynamic> _filteredItems = [];

  List<dynamic> get filteredItems => _filteredItems;

  Future<void> loadJson() async {
    final jsonString =
        await rootBundle.loadString('assets/sentences/sentences.json');
    final jsonResponse = json.decode(jsonString);
    _items = jsonResponse;
    _filteredItems = _items;
    notifyListeners();
  }

  void filterItems(String query) {
    final lowerCaseQuery = query.toLowerCase();
    _filteredItems = _items.where((item) {
      final title = item['title_arabic']?.toLowerCase() ?? '';
      final description = item['description_arabic']?.toLowerCase() ?? '';
      return title.contains(lowerCaseQuery) ||
          description.contains(lowerCaseQuery);
    }).toList();
    notifyListeners();
  }
}
