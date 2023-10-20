import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/feature/home/data/datasource/content_datasource.dart';

class LocalJsonFileContentDataSource extends ContentDataSource {
  @override
  Future<Map> fetchContent() async {
    return await rootBundle.loadStructuredData('assets/content.json',
        (String s) async {
      return json.decode(s);
    });
  }
}
