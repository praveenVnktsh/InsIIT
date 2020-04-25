import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeekDayCard {
  String day;

  WeekDayCard({this.day});

  Widget dayBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}

class FoodCard {
  String day;
  List breakfast;
  List lunch;
  List snacks;
  List dinner;

  FoodCard({this.day, this.breakfast, this.lunch, this.snacks, this.dinner});

}

class ItemModel {
  bool isExpanded;
  String header;
  List bodyModel;

  ItemModel({this.isExpanded: false, this.header, this.bodyModel});

}


