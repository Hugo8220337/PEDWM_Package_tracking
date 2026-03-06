import 'dart:convert';

import 'package:client/data/models/test_http_model.dart';
import 'package:http/http.dart' as http;

class SampleViewmodel {
  Future<List<TestHttpModel>> fetchData() async {
    final response = await http.get(Uri.parse('https://random-words-api.kushcreates.com/api?words=100'));
    final decoded = jsonDecode(response.body); // Caso a api devolva uma list ou um Map
    final items = TestHttpModel.fromJsonList(decoded);
    return items;
  }
}