import 'dart:convert';

import 'package:flutter/material.dart';

class Score {
  String name = 'Null';
  double weightage = 0.0;
  double total = 1.0;
  double score = 0.0;
  double netScore = 0.0;
  Score({
    this.name,
    this.weightage,
    this.total,
    this.score,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'weightage': weightage,
      'total': total,
      'score': score,
    };
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      name: map['name'],
      weightage: map['weightage'],
      total: map['total'],
      score: map['score'],
    );
  }

  String toJson() => json.encode(toMap());

  DataRow getRow() {
    this.netScore = score * weightage / (total);
    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(Text(score.toString())),
      DataCell(Text(total.toString())),
      DataCell(Text(weightage.toString())),
      DataCell(Text(netScore.toString())),
    ]);
  }

  factory Score.fromJson(String source) => Score.fromMap(json.decode(source));
}
