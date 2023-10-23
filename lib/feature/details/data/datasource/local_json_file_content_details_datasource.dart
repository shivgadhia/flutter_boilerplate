import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/feature/details/data/datasource/content_details_datasource.dart';

class LocalJsonFileContentDetailsDataSource extends ContentDetailsDataSource {
  @override
  Future<Map> fetchContent() async {
    return await rootBundle.loadStructuredData('assets/content-details.json',
        (String s) async {
      return json.decode(s);
    });
  }
}
