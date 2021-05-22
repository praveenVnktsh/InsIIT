import 'dart:convert';

import 'package:color_convert/color_convert.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:instiapp/data/scheduleContainer.dart';
import 'package:instiapp/themeing/notifier.dart';
import 'package:instiapp/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'scoresClass.dart';
import 'eventClass.dart';

//TODO = LINKS??, SORTING
class Course extends Event {
  bool enrolled = false;
  List ltpc = [0, 0, 0, 0];
  String code;
  String slot;
  String minor;
  double totalScore = 100.0;
  String instructors;
  String cap;
  String prerequisite;

  double totalWeight = 0.0;

  int slotType; // 0 = lecture, 1 = tutorial, 2 = lab

  List<Score> scores = [
    Score(
        name: "Endsem",
        weightage: 25,
        total: 100,
        score: 10.0,
        satScore: ScoreColors.good),
    Score(
        name: "Midsem",
        weightage: 50,
        total: 100,
        score: 10.0,
        satScore: ScoreColors.okay),
    Score(
        name: "Endsem",
        weightage: 25,
        total: 100,
        score: 100.0,
        satScore: ScoreColors.bad),
  ];

  Course({
    this.enrolled,
    this.ltpc,
    this.code,
    name,
    startTime,
    endTime,
    this.instructors,
    link,
    currentlyRunning,
    this.slot,
    this.minor,
    color,
    this.cap,
    this.slotType,
    this.prerequisite,
  }) : super(
            name: name,
            startTime: startTime,
            link: link,
            color: color,
            endTime: endTime,
            currentlyRunning: currentlyRunning);

  String getCourseType() {
    if (slotType == 0) {
      return "Lecture";
    } else if (slotType == 1) {
      return "Tutorial";
    } else {
      return "Lab";
    }
  }

  factory Course.fromSheetRow(List row, var slot, int slotType, int index) {
    var times = [DateTime.now(), DateTime.now()];
    if (slot.runtimeType != String) {
      times[0] = ScheduleContainer.getTimeFromSlot(slot[0])[0];
      times[1] = ScheduleContainer.getTimeFromSlot(slot[slot.length - 1])[1];
      slot = slot.join('+');
    } else {
      times = ScheduleContainer.getTimeFromSlot(slot);
    }
    int hue = 30 * index % 360;
    int sat = 80;
    int illum = 80 - (index ~/ 12) * 10;

    var col = convert.hsv.rgb(hue, sat, illum);
    String code = row[0].toString().replaceAll(' ', '');

    Course course = Course(
        code: code,
        name: row[1].toString(),
        ltpc: [
          row[2].toString(),
          row[3].toString(),
          row[4].toString(),
          row[5].toString()
        ],
        startTime: times[0],
        color: Color.fromARGB(100, col[0], col[1], col[2]),
        endTime: times[1],
        instructors: row[6].toString(),
        slotType: slotType,
        minor: row[7].toString(),
        cap: row[8].toString(),
        prerequisite: row[9].toString(),
        enrolled: false,
        slot: slot.toString());
    return course;
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'ltpc': ltpc,
      'startTime': [
        startTime.year,
        startTime.month,
        startTime.day,
        startTime.hour,
        startTime.minute
      ],
      'endTime': [
        endTime.year,
        endTime.month,
        endTime.day,
        endTime.hour,
        endTime.minute
      ],
      'instructors': instructors,
      'slotType': slotType,
      'minor': minor,
      'cap': cap,
      'color': color.toString(),
      'prerequisite': prerequisite,
      'enrolled': enrolled,
      'slot': slot
    };
  }

  String toJson() => json.encode(toMap());

  Future<void> navigateToDetail(context) async {
    await Navigator.pushNamed(context, '/eventdetail', arguments: {
      'event': this,
    });
  }

  @override
  Widget buildEventCard(BuildContext context, {Function callBack}) {
    String startTimeString = formatDate(startTime, [HH, ':', nn]);
    String endTimeString = formatDate(endTime, [HH, ':', nn]);
    bool ongoing =
        DateTime.now().isBefore(endTime) && startTime.isBefore(DateTime.now());

    return Card(
      color: color,
      child: Container(
        width: ScreenSize.size.width,
        child: InkWell(
          onTap: () {
            navigateToDetail(context).then((val) {
              callBack();
            });
          },
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text(startTimeString,
                        style: TextStyle(color: theme.textHeadingColor)),
                    SizedBox(
                      height: 8,
                    ),
                    Text("to",
                        style: TextStyle(
                            fontSize: 14, color: theme.textHeadingColor)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(endTimeString,
                        style: TextStyle(color: theme.textHeadingColor)),
                  ]),
                  verticalDivider(),
                  // descriptionWidget(),
                  Container(
                    width: ScreenSize.size.width * 0.55,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("$code",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: theme.textSubheadingColor)),
                          SizedBox(
                            height: 8,
                          ),
                          Text(name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: theme.textHeadingColor)),
                          SizedBox(
                            height: 8,
                          ),
                          // (this.links != null || this.links.length != 0)
                          //     ? Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: this.links.map((link) {
                          //           return GestureDetector(
                          //             onTap: () async {
                          //               if (await canLaunch(link)) {
                          //                 await launch(link, forceSafariVC: false);
                          //               } else {
                          //                 throw 'Could not launch $link';
                          //               }
                          //             },
                          //             child: Text(
                          //               link,
                          //               style: TextStyle(color: Colors.blue, fontSize: 15),
                          //             ),
                          //           );
                          //         }).toList(),
                          //       )
                          //     : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(getCourseType(),
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                      color: theme.textHeadingColor)),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ]),
                  ),
                  (ongoing == true)
                      ? Icon(
                          Icons.adjust,
                          color: Colors.green,
                        )
                      : Container(),
                ],
              )),
        ),
      ),
    );
  }

  bool sorted = false;
  @override
  Widget buildScores(BuildContext context, {Function callback}) {
    List<DataRow> tableRows = [];
    double totalScore = 0.0;

    totalWeight = 0;
    scores.forEach((Score mark) {
      tableRows.add(mark.getRow(context, callback));
      totalScore += mark.netScore;
      totalWeight += mark.weightage;
    });
    this.totalScore = totalScore;
    tableRows.add(DataRow(
        onSelectChanged: (val) {
          String newname = 'Quiz';
          double newscore = 0.0;
          double newweight = 0.0;
          double newtotal = 1.0;
          String newsatscore = 'Great!';
          showDialog(
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Text("New Exam"),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          TextFormField(
                            initialValue: newname,
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
                            initialValue: newscore.toString(),
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
                            initialValue: newtotal.toString(),
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
                            initialValue: newweight.toString(),
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
                            Color satColor;
                            if (newsatscore.compareTo('Great!') == 0) {
                              satColor = ScoreColors.good;
                            } else if (newsatscore.compareTo('Okay') == 0) {
                              satColor = ScoreColors.okay;
                            } else if (newsatscore.compareTo('Bad :/') == 0) {
                              satColor = ScoreColors.bad;
                            }
                            this.scores.add(Score(
                                name: newname,
                                total: newtotal,
                                score: newscore,
                                satScore: satColor,
                                weightage: newweight,
                                netScore: newscore * newweight / (newtotal)));
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
        cells: [
          DataCell(Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(
                      25.0) //                 <--- border radius here
                  ),
            ),
            child: Text(
              'Add exam',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          )),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text(
            'Total = ',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataCell(Text(
              '${totalScore.toStringAsFixed(2)}/${totalWeight.toStringAsFixed(2)}')),
        ]));
    sorted = !sorted;
    DataTable table = DataTable(
      showCheckboxColumn: false,
      columnSpacing: 25.0,
      sortColumnIndex: 3,
      sortAscending: false,
      rows: tableRows,
      columns: [
        DataColumn(
            label: Text(
          'Name',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataColumn(
            numeric: true,
            label: Text(
              'Score',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        DataColumn(
            numeric: true,
            label: Text(
              'Marks',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        DataColumn(
            numeric: true,
            onSort: (index, ascending) {
              scores.sort((a, b) => a.weightage.compareTo(b.weightage));
              if (sorted) {
                scores = scores.reversed.toList();
              }
              callback();
            },
            label: Text(
              'Weight %',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        DataColumn(
            numeric: true,
            label: Text(
              'Total',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );

    return Center(
      child: Container(
        width: ScreenSize.size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text("Your Performance so far",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: table)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildEventDetails(BuildContext context, {Function callback}) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarColor,
        title: Text('Course Details - ${this.name}',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: theme.textHeadingColor)),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.iconColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                  title: Text('Slot type  : ${getCourseType()}',
                      style: TextStyle(color: theme.textHeadingColor))),
              ListTile(
                title: Text(
                    "Start         : ${formatDate(startTime, [HH, ':', nn])}",
                    style: TextStyle(color: theme.textHeadingColor)),
                trailing: Icon(Icons.edit, color: theme.iconColor),
                onTap: () {
                  pickDate(context, startTime).then((time) {
                    if (time != null) {
                      startTime = DateTime(startTime.year, startTime.month,
                          startTime.day, time.hour, time.minute);
                      callback();
                    }
                  });
                },
              ),
              ListTile(
                title: Text(
                    "End           : ${formatDate(endTime, [HH, ':', nn])} ",
                    style: TextStyle(color: theme.textHeadingColor)),
                trailing: Icon(Icons.edit, color: theme.iconColor),
                onTap: () {
                  pickDate(context, endTime).then((time) {
                    if (time != null) {
                      endTime = DateTime(endTime.year, endTime.month,
                          endTime.day, time.hour, time.minute);
                      callback();
                    }
                  });
                },
              ),
              ListTile(
                  title: Text(
                      'L-T-P-C      : ${ltpc[0]} - ${ltpc[1]} - ${ltpc[2]} - ${ltpc[3]}',
                      style: TextStyle(color: theme.textHeadingColor))),
              (link != null && link.length != 0)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: link.split(',').map((link) {
                        return GestureDetector(
                          onTap: () async {
                            if (await canLaunch(link)) {
                              await launch(link, forceSafariVC: false);
                            } else {
                              throw 'Could not launch $link';
                            }
                          },
                          child: Text(
                            (link == '-') ? "" : link,
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                    )
                  : Container(),
              (minor == null)
                  ? Container()
                  : ListTile(
                      title: Text('Minor        : $minor',
                          style: TextStyle(color: theme.textHeadingColor))),
              ListTile(
                title: Text('Instructors',
                    style: TextStyle(
                        color: theme.textHeadingColor,
                        fontWeight: FontWeight.bold)),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: (instructors == null)
                      ? [Container()]
                      : instructors.split(',').map<Widget>((String instructor) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(
                              8,
                              0,
                              0,
                              0,
                            ),
                            child: Text(instructor,
                                style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: theme.textSubheadingColor)),
                          );
                        }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
