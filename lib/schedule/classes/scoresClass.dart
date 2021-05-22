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
  DateTime date = DateTime.now();
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
          String newsatscore = 'Great!';
          if (this.satScore == ScoreColors.good) {
            newsatscore = 'Great!';
          } else if (this.satScore == ScoreColors.okay) {
            newsatscore = 'Okay';
          } else if (this.satScore == ScoreColors.bad) {
            newsatscore = 'Bad :/';
          }
          showDialog(
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Performance : "),
                              DropdownButton<String>(
                                focusColor: Colors.white,
                                value: newsatscore,
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: Colors.black,
                                items: <String>[
                                  'Great!',
                                  'Okay',
                                  'Bad :/',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String value) {
                                  newsatscore = value;
                                  setState(() {});
                                },
                              ),
                            ],
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
                            if (newsatscore.compareTo('Great!') == 0) {
                              this.satScore = ScoreColors.good;
                            } else if (newsatscore.compareTo('Okay') == 0) {
                              this.satScore = ScoreColors.okay;
                            } else if (newsatscore.compareTo('Bad :/') == 0) {
                              this.satScore = ScoreColors.bad;
                            }
                            callback();
                            Navigator.of(context).pop();
                          },
                          child: Text("Apply")),
                    ],
                  );
                });
              },
              context: context);
        },
        color: MaterialStateProperty.all(this.satScore),
        cells: [
          DataCell(
              Text(name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  )),
              showEditIcon: true),
          DataCell(Text(score.toStringAsFixed(2))),
          DataCell(Text(total.toStringAsFixed(2))),
          DataCell(Text(weightage.toStringAsFixed(2))),
          DataCell(Text(netScore.toStringAsFixed(2))),
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
