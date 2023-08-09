import 'package:flutter/material.dart';

class attRecords {
  late String date;
  String? checkIn;
  String? checkOut;

  attRecords({required this.date, this.checkIn, this.checkOut});

  attRecords.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    return data;
  }
}
