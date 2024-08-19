import 'package:english_sentences/pages/daily_life/dailyife_section.dart';
import 'package:english_sentences/providers/daily_life_provider.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class DailyLifeSentences extends StatelessWidget {
  const DailyLifeSentences({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyLifeProvider = Provider.of<DailyLifeProvider>(context);
    dailyLifeProvider.loadJson();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: dailyLifeProvider.isLoading
            ? _buildLoadingSpinner()
            : kIsWeb
                ? _buildListView(context, dailyLifeProvider)
                : _buildGridView(context, dailyLifeProvider),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.deepOrange,
      title: Text(
        'اهم الجمل في الحياة اليومية',
        style: TextStyle(fontFamily: "bahja", color: Colors.white),
      ),
    );
  }

  Center _buildLoadingSpinner() {
    return Center(
      child: SpinKitFadingCircle(
        color: Colors.blue,
        size: 50.0,
      ),
    );
  }

  Widget _buildListView(BuildContext context, DailyLifeProvider provider) {
    return ListView.builder(
      itemCount: provider.sections.length,
      itemBuilder: (context, index) => _buildSectionCard(
        context,
        provider.sections[index],
        isGrid: false,
      ),
    );
  }

  Widget _buildGridView(BuildContext context, DailyLifeProvider provider) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: provider.sections.length,
      itemBuilder: (context, index) => _buildSectionCard(
        context,
        provider.sections[index],
        isGrid: true,
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, Map<String, dynamic> section,
      {required bool isGrid}) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DailyLifeSection(sectionName: section),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(section['key_icon']),
            SizedBox(height: isGrid ? 4 : 0),
            _buildText(section['section_ar'], isGrid),
            SizedBox(height: 10),
            _buildText(section['section_en'], isGrid, isSubtitle: true),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String iconKey) {
    return iconKey.isEmpty
        ? Icon(Icons.image, size: 40)
        : SvgPicture.asset(
            'assets/icons/$iconKey.svg',
            height: 40,
          );
  }

  Text _buildText(String? text, bool isGrid, {bool isSubtitle = false}) {
    return Text(
      text ?? "",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: isSubtitle ? 14 : 15,
        fontWeight: isSubtitle ? FontWeight.normal : FontWeight.bold,
        fontFamily: "bahja",
      ),
      textAlign: TextAlign.center,
    );
  }
}
