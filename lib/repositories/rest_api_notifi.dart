import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shopwhey_app_2022/models/models.dart';
import 'package:http/http.dart' as http;

class RestApiNotifi{

  Future<List<Notifi>> fetchPhotos(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseNotifi, response.body);
  }

  List<Notifi> parseNotifi(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Notifi>((json) => Notifi.fromJson(json)).toList();
  }
}