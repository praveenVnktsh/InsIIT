import 'dart:convert';

import 'package:flutter/material.dart';

class ScoreColors {
  static Color good = Colors.green.withAlpha(100);
  static Color bad = Colors.red.withAlpha(100);
  static Color okay = Colors.orange.withAlpha(100);
}

class Score {
  String name = 'Null';
  double weightage = 0.0;
  double total = 1.0;
  double score = 0.0;
  double netScore = 0.0;
  Color satScore = ScoreColors.good;
  Score(
      {this.name,
      this.weightage,
      this.total,
      this.score,
      this.satScore,
      this.netScore});

  DataRow getRow() {
    this.netScore = score * weightage / (total);
    InputDecoration dec = InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: "Hint here");
    return DataRow(
        // onSelectChanged: (val) {},
        color: MaterialStateProperty.all(this.satScore),
        cells: [
          // DataCell(
          //   TextFormField(
          //     initialValue: name,
          //     style: TextStyle(fontSize: 14),
          //     decoration: dec,
          //     onFieldSubmitted: (val) {
          //       name = val;
          //     },
          //   ),
          // ),
          // DataCell(
          //   TextFormField(
          //     initialValue: score.toString(),
          //     style: TextStyle(fontSize: 14),
          //     decoration: dec,
          //     onFieldSubmitted: (val) {
          //       score = double.parse(val);
          //     },
          //   ),
          // ),
          // DataCell(
          //   TextFormField(
          //     initialValue: total.toString(),
          //     style: TextStyle(fontSize: 14),
          //     decoration: dec,
          //     onFieldSubmitted: (val) {
          //       total = double.parse(val);
          //     },
          //   ),
          // ),
          // DataCell(
          //   TextFormField(
          //     initialValue: weightage.toString(),
          //     style: TextStyle(fontSize: 14),
          //     decoration: dec,
          //     onFieldSubmitted: (val) {
          //       weightage = double.parse(val);
          //     },
          //   ),
          // ),
          // DataCell(
          //   TextFormField(
          //     initialValue: netScore.toString(),
          //     style: TextStyle(fontSize: 14),
          //     decoration: dec,
          //     onFieldSubmitted: (val) {
          //       netScore = double.parse(val);
          //     },
          //   ),
          // ),
          DataCell(Text(name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ))),
          DataCell(Text(score.toString())),
          DataCell(Text(total.toString())),
          DataCell(Text(weightage.toString())),
          DataCell(Text(netScore.toString())),
        ]);
  }

  factory Score.fromJson(String source) => Score.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'weightage': weightage,
      'total': total,
      'score': score,
      'netScore': netScore,
      'satScore': satScore.value,
    };
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      name: map['name'],
      weightage: map['weightage'],
      total: map['total'],
      score: map['score'],
      netScore: map['netScore'],
      satScore: Color(map['satScore']),
    );
  }

  String toJson() => json.encode(toMap());
}
