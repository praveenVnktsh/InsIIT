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

  DataRow getRow(context, Function callback) {
    this.netScore = score * weightage / (total);
    InputDecoration dec = InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: "Hint here");
    return DataRow(
        onSelectChanged: (val) {
          String newname = this.name;
          double newscore = this.score;
          double newweight = this.weightage;
          double newtotal = this.total;
          showDialog(
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Edit Exam"),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: this.name,
                          decoration: InputDecoration(
                            labelText: 'Exam Name',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) {
                            newname = val;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: this.score.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Your Score',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) {
                            newscore = double.parse(val);
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: this.total.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Exam Total',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) {
                            newtotal = double.parse(val);
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: this.weightage.toString(),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Exam Weightage (%)',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) {
                            newweight = double.parse(val);
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          this.score = newscore;

                          this.name = newname;
                          this.total = newtotal;
                          this.weightage = newweight;
                          this.netScore = score * weightage / (total);
                          callback();
                          Navigator.of(context).pop();
                        },
                        child: Text("Apply")),
                  ],
                );
              },
              context: context);
        },
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
