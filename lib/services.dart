import 'dart:convert';

import 'package:covid_19_app/utils/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/WordStateModel.dart';

class Services {
  Future<WordStateModel> World_Data() async {
    final response = await http.get(Uri.parse(AppUrl.WorldStateUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WordStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> Counter_Data() async {
    final response = await http.get(Uri.parse(AppUrl.CounterUrl));
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
