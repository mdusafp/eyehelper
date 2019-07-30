import 'package:flutter/material.dart';

class TrainingController {
  List<int> passedIndices;

  TrainingController(){
    passedIndices = [];
  }

  addIndex(int index){
    passedIndices.add(index);
    passedIndices.sort();
  }
}
